extends Area2D
var monedas: Array = []
@onready var bolsa = $"../bolsa"
@onready var stone = $Stone
@onready var player = $"../Player"

var current_lvl = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	monedas = get_tree().get_nodes_in_group("coin")
	current_lvl = get_tree().current_scene.name

func _process(_delta):
	
	if bolsa.counter_coin == monedas.size():
		stone.hide()
	else:
		stone.show()

func change_lvl():
	if current_lvl == "Level1":
			get_tree().change_scene_to_file("res://scenes/environment/level_2.tscn")
	elif current_lvl == "level_2":
			get_tree().change_scene_to_file("res://scenes/environment/level_3.tscn")
	elif current_lvl == "level_3":
			get_tree().change_scene_to_file("res://scenes/environment/level_4.tscn")
	elif current_lvl == "level_4":
			get_tree().change_scene_to_file("res://scenes/environment/win.tscn")

func _on_body_entered(body):
	if body == player and player.grab_input == true and !stone.is_visible_in_tree():
		change_lvl()
