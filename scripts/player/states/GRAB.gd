extends "res://scripts/player/state.gd"
#pasiencia con el sketch que esta en proceso, creo que lo estoy haciendo mal (?

var grabing = true
@onready var Bolsa = get_tree().get_first_node_in_group("bolsa")


func update(delta):
	#aca se indica de que fomra sale del estado 
	#(si este escript se ejecuta es porque ya esta en el estado) 
	return null

func enter_state():
	#aca se aplicarian los "trades de la bolsa" cuando la agarra
	grabing = true
	pass

func exit_state():
	#aca se quitan los "trades de la bolsa" cuando la suelta
	grabing = false
	pass

