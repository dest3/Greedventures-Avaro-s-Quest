extends Area2D
class_name interactionArea

@export var action_name = "interact"

var interact: Callable = func():
	pass

#agrega el area a la lista de areas
func _on_body_entered(body):
	InteractionManager.register_area(self)

#quita el area de la lista
func _on_body_exited(body):
	InteractionManager.unregister_area(self)
