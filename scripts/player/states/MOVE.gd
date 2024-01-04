extends "res://scripts/player/state.gd"

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
	return null
func enter_state():
	Player.can_dash = true #resetea el dash
