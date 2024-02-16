extends Control

@onready var input_button_scene = preload("res://scenes/UI/Input setings/input_button.tscn")
@onready var acction_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remaping = false #si esta cambiando o no un boton 
var action_to_remap = null #que accion quiere cambiar 
var remaping_button = null #que boton se cambia

#lista de acciones para remapear
var input_actions = {
	"MoveUp" : "Move up",
	"MoveDown" : "Move down",
	"MoveLeft" : "Move left",
	"MoveRight" : "Move rigth",
	"Dash" : "Dash",
	"Jump" : "Jump",
	"Climb" : "Climb",
	"interact" : "Interact",
	"Grab": "Grab",
	"Drop": "Drop",
	"Launched": "Launched" 
	}


func _ready():
	_create_action_list()
	

func _create_action_list():
	InputMap.load_from_project_settings() #carga la lista de acciones en el mapa de entrada
	for item in acction_list.get_children(): #reccorre cada accion de la lista
		item.queue_free() #borra el contenido de la lista para dejarlo en blanco 
	
	for action in input_actions: #reccorre la lista de acciones 
		var button = input_button_scene.instantiate()#crea una variable para instanciar un boton por cada accion de la lista
		var action_label = button.find_child("LabelAction") #obtinee el label de la accion del boton por el nombre del hijo 
		var input_label = button.find_child("LabelInput") #obtinee el label del boton
		
		action_label.text = input_actions[action] #cambia el contenido del label por el nombre de la accion 
		
		var events = InputMap.action_get_events(action) #guarda las aciones de la lista en events
		
		if events.size() >0: #si hay 1 evento 
			input_label.text = events[0].as_text().trim_suffix(" (Physical)") #agrega el nombre del evento en string al input label
		else: #si no hay evento el input label queda vacio
			input_label.text = ""
		
		acction_list.add_child(button) #agrega al menu un boton por cada accion 
		button.pressed.connect(_on_input_button_pressed.bind(button, action)) #conecta la señan pressed con la funcion con un valor guardado de el boton y el valor 
		
		
#cambia el texto del label para indicar que se presione un nuevo boton 
func _on_input_button_pressed(button, action):
	if is_remaping == false:
		is_remaping = true
		action_to_remap = action #guarda la accion a cambiar
		remaping_button = button #guarda el boton
		button.find_child("LabelInput").text = "Press key to bind..." #aca le dice que toque algo 

func _input(event):
	if is_remaping: # si esta remapeando
		if (#si se aprieta o un boton del mouse
			event is InputEventKey || 
			(event is InputEventMouseButton && event.pressed)
		):
			#evita que el input sea doble clik
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_event(action_to_remap, event) #borra la accion seleccionada 
			InputMap.action_add_event(action_to_remap, event) #agrega la accion nueva
			_update_action_list(remaping_button, event)#actualiza la lista de acciones
			
			#vuelve a setear de 0 las variables 
			is_remaping = false
			action_to_remap = null
			remaping_button = null
			
			#actualiza 
			accept_event()


func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func _on_reset_button_pressed():
	_create_action_list()
