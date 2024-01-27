extends Node2D

var cache : Dictionary = {}

@export_dir var item_folder

#al iniciar toma una referencia de la carpeta donde se contendran todos los items
#y los guarda en una lista de "cache"
#se podria investigar la posibilidad de adaptar el sistema para que recorra varias carpetas distintas con items dentro

func _ready():
	var folder =  DirAccess.open("res://resourses/item/") #accede a la carpeta 
	folder.list_dir_begin()#inicia una lista de directorios 
	
	var file_name= folder.get_next()#y guarda el nombre en file_name 
	
	while file_name != "": #mientas que el nombre no sea un string vacio (osea que no haya nada mas)
		
		cache[file_name] = load("res://resourses/item/" + file_name)#guarda el recurso de la carpeta y con el nombre en la lista de cahce
		
		file_name =folder.get_next()#sigue con el siguiente archivo 


func get_item(ID):
	return cache[ID + ".tres"] #devuelve el recurso

