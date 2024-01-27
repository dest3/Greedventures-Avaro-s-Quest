extends Sprite2D
class_name AbstracItem

#variable de seteo de tipo Item 
var stats: Item = null:
	set(value):
		stats=value
		#si value no es nulo le asigna la textura del recuso
		if value != null:
			texture = value.icon


func _ready():
	#test
	stats = ItemDatabase.get_item("Helmet common")
