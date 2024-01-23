extends Node2D

var peso_moneda = 5
@onready var Player = get_tree().get_first_node_in_group("player")
@onready var bolsa = get_tree().get_first_node_in_group("bolsa")
@onready var sprite  = $AnimatedSprite2D
@onready var area = $Area2D
@onready var colision = $Area2D/CollisionShape2D
func _ready():
	pass


func _on_area_entered(area):
	if Player.is_in_group("player"):
		bolsa.peso += peso_moneda
		sprite.play("pick_up")
		await sprite.animation_finished
		queue_free()
		 # Replace with function body.
