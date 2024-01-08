extends RigidBody2D
#bolsa de avaro, aca van todos sus estados, para ser accedidos 

func _on_area_2d_body_entered(body):
	##aca todo lo que queremos que pase cuando el personaje se acerque a la bolsa
	var Player = body#guarda el body 
	if body.name == "Player": #si es el nodo jugador entonces 
		#queue_free()
		pass
	
