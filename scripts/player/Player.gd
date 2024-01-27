extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#variables del input del jugador
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false 
var dash_input = false
var interact_input = false
#player movement
@export var SPEED = 70.0
@export var air_jumps_total : int = 1 #cantidad maxima de saltos en el aire
var air_jumps_current : int = air_jumps_total #cantidad actual

@export var jump_height : float = 30 #alto del salto 
@export var jump_time_to_peak : float = 0.5 # tiempo que tarda en llegar arriba 
@export var jump_time_to_descent : float = 0.25 # tiempo que tarda en bajar 

#aca aplica la black magic fukery de las matematicas 
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var PUSH_FORCE = 100
var last_direction = Vector2.RIGHT

#mecanicas
var can_dash = true
var can_interact = true

#estados
var current_state = null
var prev_state = null

#referencia a nodos
@onready var STATES = $STATES
@onready var Raycasts = $Raycasts

#esta funcion recorre todos los estados de STATES, los almacena y hace una referencia a la variable Player del script "state"
func _ready():
	# registramos el player en el InteractionManager. Esto se podria hacer en _init() o _enter_tree()
	# pero en ready es cuando ya todos los subnodos del player estan listos y accesibles
	InteractionManager.Player = self

	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE

func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())
	move_and_slide()
	
	#aca aplico la fuerza de empuje del personaje
	for i in get_slide_collision_count():#obtiene todas las coliciones al moverse
		var c = get_slide_collision(i)#guarda la colision en c
		if c.get_collider() is RigidBody2D:#si c es un rigidbody
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)#aplica la fuerza

#agrega la gravedad si no esta en el suelo
func gravity(delta):
	if not is_on_floor():
		velocity.y += get_gravity() * delta

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


# esta funcion cambia de estados y actualiza el estado actual del jugador
#si el input state es distinto de null
func change_state(input_state):
	if input_state != null:
		prev_state = current_state 
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

#esta funcion comprueba si esta cerca de una pared
func get_next_to_wall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update() 
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

#esta funcion gestiona todo el input del jugador:
func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
	
	# jumps
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else: 
		jump_input = false
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else: 
		jump_input_actuation = false
	
	#climb
	if Input.is_action_pressed("Climb"):
		climb_input = true
	else: 
		climb_input = false
	
	#dash
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
	else: 
		dash_input = false
	
	#agarrar
	if Input.is_action_just_pressed("interact") and can_interact:
		interact_input = false
	else: 
		interact_input = true









