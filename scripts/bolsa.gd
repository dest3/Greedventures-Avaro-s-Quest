extends RigidBody2D
#bolsa de avaro, aca van todos sus estados, para ser accedidos 

const lines: Array[String]= [
	"hola este es el primer test del sistemas de dialogo",
	"la verdad no se que esperar de esto",
	"pero bueno aguante la godoneta qsy..."
]

@onready var interaction_area: interactionArea = $InteractionArea#referencia al area de interaccion 
@onready var Player = get_tree().get_first_node_in_group("player")# referencia al player


func _ready():
	interaction_area.interact = Callable(self, "on_interact")

func on_interact():#jjgbjbh
	DialogManager.start_dialog(global_position, lines)
	
