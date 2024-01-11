extends RigidBody2D
#bolsa de avaro, aca van todos sus estados, para ser accedidos 

@onready var interaction_area: interactionArea = $InteractionArea
@onready var Player = get_tree().get_first_node_in_group("player")

var peso = 0

func _ready():
	interaction_area.interact = Callable(self, "on_interact")

func on_interact():
	queue_free()
