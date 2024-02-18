extends Area2D

@onready var player = $"../Player"


func _on_body_entered(body):
	if body == player:
		MusicControler.stop_music()
		get_tree().change_scene_to_file("res://scenes/environment/lose.tscn")




