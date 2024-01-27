extends "res://scripts/player/state.gd"

func update(_delta):
	if Player.jump_input_actuation:
		return STATES.IDLE

func enter_state():
	Player.hide()
	get_tree().change_scene_to_file("moriste")

func exit_state():
	Player.show()
