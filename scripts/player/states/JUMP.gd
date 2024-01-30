extends "res://scripts/player/state.gd"
@onready var bolsa = get_tree().get_first_node_in_group("bolsa")
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
	

	
	return null

func enter_state():
	Player.velocity.y = Player.JUMP_VELOCITY #aplica el salto 
	Player.sprite.play("jump")
	

