extends Area2D

@onready var bolsa = get_tree().get_first_node_in_group("bolsa")
@onready var Player = get_tree().get_first_node_in_group("player")

func _on_body_entered(_body):
	MusicControler.stop_music()
	get_tree().change_scene_to_file("res://scenes/environment/lose.tscn")
	

#que la bolsa reespawnee , lo hace de por si sin la funcion de abajo ... raro la verdad 
#func _on_area_entered(area):
	#if bolsa.is_in_group("bolsa"):
		#bolsa.position = Player.position
