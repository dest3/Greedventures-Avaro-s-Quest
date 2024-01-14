extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $leterDisplayTimer

const MAX_WIDTH = 256 #ancho maximo

var text = ""  #texto a ser mostrado 
var letter_index = 0 #index de cada letra para mostrar texto letra por letra
var letter_time = 0.03 #tiempo entre letras 
var space_time = 0.06 #tiempo de espacios 
var punctuation_time = 0.2 #tiempo de puntiaciones

signal finished_displaying()

#esta funcion muestra el texto a ser mostrado. 
func display_text(text_to_display : String): #toma un parametro de tipo texto
	text = text_to_display #guarda el texto del parametro en text
	label.text = text_to_display #asigna el texto del parametro a el label
	
	await resized #espera a que el texto termine de acomodarse en el tamaño 
	custom_minimum_size.x = min(size.x, MAX_WIDTH) #ajusta el tamaño maximo al minimo valor del ancho maximo
	
	if size.x > MAX_WIDTH:#si el tamaño del texto supera el ancho maximo 
		label.autowrap_mode = TextServer.AUTOWRAP_WORD#lo baja a una nueva linea y vuelve a ajustar el tamaño 
		await resized # espera a que se ajuste en X
		await resized # espera a que se ajuste en Y
		custom_minimum_size.y = size.y #guarda el nuevo tamaño minimo de y en el texto
	
	global_position.x -= size.x /2 #centra el texto en el eje x
	global_position.y -= size.y + 24 #sube el texto un poco en y para estar arriba del que habla
	
	label.text = "" #setea el texto a un string vacio
	
	display_letter() # llama a display leter
	
func display_letter():
	label.text += text[letter_index]# suma el texto completo letra por letra
	letter_index += 1# aumenta el index para mostrar la letra siguiente
	
	if letter_index >= text.length():#si el index es el mismpo tamaño que el texto completo 
		finished_displaying.emit() #emite señal de que termino 
		return# finlaiza la funcion
	match text[letter_index]: # si el index del texto es igual a
		"!",".",",","?": #estos signos
			timer.start(punctuation_time)# activa el timer de la puntuacion 
		" ": # a un espacio 
			timer.start(space_time) #activa el tiempo de los espacios
		_: #en cualquier otro caso
			timer.start(letter_time) # activa el tiempo de las letras

#cuando se acaba el timer
func _on_leter_display_timer_timeout():
	display_letter()
