extends Node2D

func _input(_event):
	if Input.is_action_just_pressed("prueba"):
		
		get_tree().paused = not get_tree().paused
