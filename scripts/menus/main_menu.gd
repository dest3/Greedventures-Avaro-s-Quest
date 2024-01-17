extends Control
class_name main_menu

@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/play
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/options
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/quit


func _on_play_button_down():
	get_tree().change_scene_to_file("res://scenes/environment/world.tscn")


func _on_options_button_down():
	pass # Replace with function body.


func _on_quit_button_down():
	get_tree().quit()
