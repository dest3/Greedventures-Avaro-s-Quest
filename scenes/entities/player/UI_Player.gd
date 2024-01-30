extends Control

@onready var contador_monedas = $Counter
@onready var bolsa = get_tree().get_first_node_in_group("bolsa")
func _process(_delta):
	contador_monedas.text =  str(bolsa.counter_coin) 
