extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#variables del input del jugador
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false 
var dash_input = false

#player movement
@export var SPEED = 70.0
@export var JUMP_VELOCITY = -400.0
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

#agrega la gravedad si no esta en el suelo
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta

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
	if Input.is_action_just_pressed("interact"):
		can_interact = false
	else: 
		can_interact = true









