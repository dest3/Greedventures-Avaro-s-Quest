extends Node


@onready var text_box_scene = preload("res://scenes/UI/textbox.tscn")

var dialog_lines: Array[String]=[] #aca se guardan los dialogos 
var current_line_index = 0 # esto se usa para saber en que linea esta el texto

var text_box #se usa para referenciar el text box
var text_box_position: Vector2 # aca se guarda la posision

var is_dialog_active = false #si esta hablando o no 
var can_advance_line = false #si se completo un renglon y puede avanzar

func start_dialog(position:Vector2, lines: Array[String]):
	if is_dialog_active:
		return
	
	dialog_lines = lines #guarda las lineas del parametro en diaglog lines
	text_box_position = position #guarda la posicion del parametro en text position 
	show_text_box() 
	is_dialog_active = true 

#esta funcion instancia el text box en la escena
func show_text_box():
	text_box = text_box_scene.instantiate()#aca guarda una instancia nueva de la textbox en text_box
	text_box.finished_displaying.connect(on_text_box_finished_displaying)#aca conecta la señal para que cuando termine llame a la funcion 
	get_tree().root.add_child(text_box)#esta linea crea en el tree la instancia guardada en text box
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line= false
	
func on_text_box_finished_displaying():
	can_advance_line= true

func _unhandled_input(event):
	if(
		event.is_action_pressed("interact") and 
		is_dialog_active and 
		can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1 
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return
		show_text_box()
