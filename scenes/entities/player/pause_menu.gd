extends Control

@onready var menu = $ColorRect
var tamaño_x = size.x
var tamaño_y = size.y
func _ready():
	visible = false
func _input(_event):
	if Input.is_action_just_pressed("prueba"):
		visible = not visible
		get_tree().paused = not get_tree().paused
