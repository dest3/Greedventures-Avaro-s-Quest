extends Control
class_name main_menu


#mati estas onready te daban errores en el depurador
#no las elimino pero si las comento , creo que no hacen nada sin ofender 

#@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/play
#@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/options
#@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/quit
#--------------------
func _ready():
	pass
	
#al apretar ESC va al menu , funciona de momento para el tsnc de WIN, LOSE y de OPCIONES
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/UI/menu/main_menu.tscn")
		
#va a nivel 1 
func _on_play_button_down():
	get_tree().change_scene_to_file("res://scenes/videos/video_intro.tscn")

#va a opciones
func _on_options_button_down():
	get_tree().change_scene_to_file("res://scenes/UI/menu/test_scene.tscn")

#cierra el juego 
func _on_quit_button_down():
	get_tree().quit()

#vuelve al menu principal desde opciones
func _on_volver_video_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/menu/main_menu.tscn")





func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/menu/main_menu.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/menu/main_menu.tscn")
