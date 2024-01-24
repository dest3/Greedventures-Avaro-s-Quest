extends Node

#referencia a variables
var STATES = null
var Player = null

#esta funcion gestiona lo que pasa al ingresar a un estado.
func enter_state():
	pass
#esta funcion gestiona lo que pasa al salir de un estado.
func exit_state():
	pass
#esta funcion gestiona que pasa mienstras se esta en ese estado.
func update(_delta):
	return null

func player_movement():
	if Player.movement_input.x >0:
		Player.velocity.x = Player.SPEED
		Player.last_direction = Vector2.RIGHT
		Player.sprite.flip_h = false
		Player.Fake_bag.position.x = -3 #cambia de lugar a la falsa bolsa
		Player.pi.position.x = 10#made in jony , se cambia la posicion del marker2d 
		
	elif Player.movement_input.x <0:
		
		Player.pi.position.x = -10#lo mismo ...
		Player.Fake_bag.position.x = 3 #cambia de lugar a la falsa bolsa
		Player.sprite.flip_h = true 
		Player.velocity.x = - Player.SPEED
		Player.last_direction = Vector2.LEFT
		
	else:
		Player.velocity.x = 0
		
	
		
