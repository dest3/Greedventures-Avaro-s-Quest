extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#variables del input del jugador
var movement_input = Vector2.ZERO
var jump_input = false
var counter_jump = 0
var max_jump = 2 
var jump_input_actuation = false
var climb_input = false 
var dash_input = false
var interact_input = false
var grab_input = false
var drop_input = false
var pausado : bool = false
#player movement
@export var SPEED = 100.0
@export var JUMP_VELOCITY = -400.0
@export var PUSH_FORCE = 100
var last_direction = Vector2.RIGHT

#mecanicas

var can_dash = true
var can_interact = true
var can_grab = true
var can_pick = true
var can_throw = false
#estados
var current_state = null
var prev_state = null

#referencia a nodos
@onready var STATES = $STATES
@onready var Raycasts = $Raycasts
@onready var pi = $Marker_Grab
@onready var sprite  = $Sprite2D 
@onready var Fake_bag = $Fake_bag


@onready var bolsa = get_tree().get_first_node_in_group("bolsa")

#esta funcion recorre todos los estados de STATES, los almacena y hace una referencia a la variable Player del script "state"
func _ready():
	sprite.flip_h = false
	Fake_bag.hide()# la falsa bolsa esta por defecto oculta
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
		if c.get_collider() is RigidBody2D :#si c es un rigidbody
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)#aplica la fuerza
	
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
		jump_input = true
	
		
		
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
	#interactuar
	if Input.is_action_just_pressed("interact") and can_interact:
		interact_input = false
	else: 
		interact_input = true
	
	#grab ---jony
	if Input.is_action_just_pressed("Grab") and bolsa.is_caught == true  :
		grab_input = true
		Fake_bag.show()
		bolsa.hide() 
	
	#peso de la bolsa / jony
	#ligero problema con el match , si se usan decimales estamos en el horno
	# porque no entra en la condicion o porque no se usarlo bien 
	# creo que no lo se usar bien :( 
	"""match bolsa.peso: 
		# no se como mierda lo hice pero funciona el match
		#De 15 a 20 Moderada: reduccion del 5% en la agilidad
		15:if bolsa.peso >= 15  and grab_input == true :
			var l = 100
			var velo = l - (l * 0.05)
			SPEED = velo
		#else :SPEED = 100
		#De 20 a 25 Pesada: reduccion del 10% en la agilidad
		20:if bolsa.peso >= 20  and grab_input == true :
			var l = 100
			var velo = l - (l * 0.10)
			SPEED = velo
		#else :SPEED = 100
		#De 25 a 30 Moderadamente Pesada : reduccion del 20% en la agilidad 
		30:if bolsa.peso >= 25  and grab_input == true :
			var l = 100
			var velo = l - (l * 0.20)
			SPEED = velo
		else :SPEED = 100
		# De 30 a 40 Muy Pesada : reduccion del 50 % en la agilidad
		40:if bolsa.peso >= 30 and bolsa.peso <= 40  and grab_input == true :
			var l = 100
			var velo = l - (l * 0.50)
			SPEED = velo
		else :SPEED = 100
		_:if grab_input == false:
			SPEED = 100"""
			
			
		#peso de la bolsa / same pero con if / jony
	#De 15 a 20 Moderada: reduccion del 5% en la agilidad
	if bolsa.peso >= 15  and grab_input == true :
		var l = 100
		var velo = l - (l * 0.05)
		SPEED = velo
		#De 20 a 25 Pesada: reduccion del 10% en la agilidad
		if bolsa.peso >= 20  and grab_input == true :
			velo = l - (l * 0.10)
			SPEED = velo
		#De 25 a 30 Moderadamente Pesada : reduccion del 20% en la agilidad
		if bolsa.peso >= 25  and grab_input == true :
			velo = l - (l * 0.20)
			SPEED = velo
		# De 30 a 40 Muy Pesada : reduccion del 50 % en la agilidad
		if bolsa.peso >= 30  and grab_input == true :
			velo = l - (l * 0.50)
			SPEED = velo
	else:
		SPEED = 100
	print("Velocidad del jugador " ,SPEED)
	
	#drop---jony
	if Input.is_action_just_pressed("Drop"):
		grab_input = false
		bolsa.freeze = false # freeze y sleeping en false le devuelven la fisica a la bolsa
		bolsa.sleeping=  false
		#bolsa.colision.disabled= false
		Fake_bag.hide()
		bolsa.show()
		
	
	#lanzar-------------------------- jony
	if Input.is_action_just_pressed("Launched") and grab_input:#si grab es true ( solo para si esta agarrado)
		grab_input = false # se deshabilita el agarrado (para asi lanzarlo)
		can_throw = true # se setea en true 
		#bolsa.colision.disabled= false
		Fake_bag.hide()
		bolsa.show()
		if grab_input == false and can_throw and sprite.flip_h == false :# si se cumple
			bolsa.apply_impulse(Vector2(150,-450), Vector2(0,0)) #se aplica un impulso al eje x/y
		if grab_input == false and can_throw and sprite.flip_h == true :
			bolsa.apply_impulse(Vector2(-150,-450), Vector2(0,0))








