extends Control
class_name main_menu

@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/play
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/options
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/quit

#va a nivel 1 
func _on_play_button_down():
	get_tree().change_scene_to_file("res://scenes/environment/world.tscn")

#va a opciones
func _on_options_button_down():
	get_tree().change_scene_to_file("res://scenes/UI/menu/test_scene.tscn")

#cierra el juego 
func _on_quit_button_down():
	get_tree().quit()

#vuelve al menu principal desde opciones
func _on_volver_video_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/menu/main_menu.tscn")
