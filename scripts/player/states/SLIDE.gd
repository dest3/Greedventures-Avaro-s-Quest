extends "res://scripts/player/state.gd"

#variables de trepar
@export var climb_speed = 50
@export var slide_friction = .7

#desde trepar/slide puede entrar a 
#JUMP, FALL y IDLE
func update(delta):
	slide_movement(delta)
	if Player.get_next_to_wall() == null:
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.is_on_floor() and Player.get_next_to_wall() == null:
		return STATES.IDLE
	return null

func slide_movement(delta):
	if Player.climb_input: #si aprieta trepar
		if Player.movement_input.y < 0: #si aprieta arriba mientras esta trepando
			Player.velocity.y = -climb_speed #se mueve hacia arriba
		elif Player.movement_input.y > 0: #si aprieta abajo mientras esta trepando
			Player.velocity.y = climb_speed #se mueve hacia abajo 
		else:
			Player.velocity.y = 0 #si no ingresa ninguna direccion se queda quieto aca tendriamos que poner el tema de que tanto puede trepar 
		
	else: #sino aprieta trepar
		player_movement() #se puede mover
		Player.gravity(delta) #se le aplica la gravedad
		if Player.is_on_wall_only():
			Player.velocity.y *= slide_friction # se le aplica la friccion
		
