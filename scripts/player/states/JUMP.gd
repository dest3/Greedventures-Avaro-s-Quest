extends "res://scripts/player/state.gd"

#desde el salto puede entrar a 
#FALL y DASH
func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.y >0: 
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.climb_input and Player.get_next_to_wall() != null and Player.velocity.y >0:
		return STATES.SLIDE
	print(Player.air_jumps_current)
	return null

func enter_state():
	Player.get_node("AnimationPlayer").play("jump")
	jump() #aplica el salto

func jump():
	Player.air_jumps_current = Player.air_jumps_total
	Player.velocity.y = Player.jump_velocity

