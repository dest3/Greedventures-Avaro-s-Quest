extends Node2D

#referencia a los nodos plauer y label
@onready var Player = get_tree().get_first_node_in_group("player")
@onready var label = $Label


const base_text = "[E] to " #texto inicial que se muestra cuando se entra a un area de interaccion 

var active_areas = [] #esta variable va a guardar todas las areas con las que se puede interactuar
var can_interact = true #si puede o no interactuar 

#esta funcion agrega todas las areas con la que colicione al jugador, a la lista
func register_area(area : interactionArea):
	active_areas.push_back(area)#agrega el area

#esta funcion busca en la lista de areas el area con el index espesificado y la saca de la lista
func unregister_area(area : interactionArea):
	var index = active_areas.find(area)#guarda el index
	if index != -1:#si el index existe 
		active_areas.remove_at(index)#lo fleta

#esta funcion controla si hay areas y muestra el label correspondiente
func _process(delta):
	if active_areas.size() > 0 && Player.can_interact: #si la lista es mayor a 0
		active_areas.sort_custom(_sort_by_distance_to_player)# devuelve el area mas cercana al player con sort custom
		label.text = base_text + active_areas[0].action_name #asigna el nombre correcto al label
		label.global_position = active_areas[0].global_position # ubica el label en pantalla encima del objeto a interactuar 
		label.global_position.y -= 36 # centra el label en el eje y
		label.global_position.x -= label.size.x / 2 # centra el label en el eje x
		label.show() #nuestra el label
	else:
		label.hide()#esconde el label si no hay areas cerca


#esta funcion obtiene la posicion de cada area y devuelve la mas cercana al jugador
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = Player.global_position.distance_to(area1.global_position)
	var area2_to_player = Player.global_position.distance_to(area2.global_position)
	return area1_to_player - area1_to_player
	
	
	
func _input(event):
	#si aprieta interactuar y puede 
	if event.is_action_pressed("interact") && can_interact:
		#comprueba si hay areas de interaccion activas
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true



	
	
	
	
	
	
	
	
	
	
	
	
