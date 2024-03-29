extends "res://scripts/player/state.gd"

#referencia al timer
@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .2 #tiempo del coyote time
@onready var bolsa = get_tree().get_first_node_in_group("bolsa")
var can_jump = true
var counter_jump = 1
var max_jump = 2
var doble = false

#desde FALL puede entrar a 
#IDLE, DASH, SLIDE, JUMP
func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.is_on_floor():
		counter_jump = 1
		return STATES.IDLE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.get_next_to_wall() != null :
		return STATES.SLIDE
	if Player.jump_input_actuation and can_jump:
		return STATES.JUMP
	if Player.jump_input_actuation and counter_jump < max_jump :
		counter_jump += 1
		if Player.SPEED > 51:# si la velocidad del player es mayor a 51 , entonces puede saltar
			return STATES.JUMP

	#if Player.grab_input :
		#return STATES.GRAB
	

	return null
	

func enter_state():
	#si el estado anterior es IDLE, MOVE o SLIDE puede saltar  
	Player.sprite.play("fall")
	if Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE :
		can_jump = true
		CoyoteTimer.start(coyote_duration) #inica el timer
	else: 
		can_jump = false
		

func _on_coyote_timer_timeout():
	can_jump = false #desactiva el salto cuando se acaba el timer
	
	
	
