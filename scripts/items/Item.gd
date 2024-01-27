extends Resource
class_name Item

#variables exportadas para definir caracteristicas del item
@export var icon: Texture2D #imagen de referencia
@export var name: String #nombre

@export_enum("weapon","armor","potion", "gold") #tipo de item
var type: String = "wapon"

@export_enum("Common", "Rare", "Epic", "Legendary")
var rarity: String = "Common"

@export_multiline var description : String 


signal item_used 

func use_item():
	item_used.emit()
