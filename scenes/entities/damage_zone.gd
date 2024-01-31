extends Area2D



func _on_body_entered(body):
	MusicControler.stop_music()
	get_tree().change_scene_to_file("res://scenes/environment/lose.tscn")
	
