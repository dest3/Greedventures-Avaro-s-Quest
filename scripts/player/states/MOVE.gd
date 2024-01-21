extends "res://scripts/player/state.gd"
@onready var Bolsa = get_tree().get_first_node_in_group("bolsa")
#el jugador puede entrar a los siguentes estados desde "MOVE"
#IDLE, FALL, JUMP, DASH
func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.x == 0:
		return STATES.IDLE
	if Player.velocity.y >0:
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.grab_input :
		return STATES.GRAB
	
		
	
	return null
func enter_state():
	Player.can_dash = true #resetea el dash


