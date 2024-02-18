extends RigidBody2D

#bolsa de avaro, aca van todos sus estados, para ser accedidos 

const lines: Array[String]= [
	"hola este es el primer test del sistemas de dialogo",
 
	  
]

@onready var interaction_area: interactionArea = $InteractionArea
@onready var Player = get_tree().get_first_node_in_group("player")
@onready var colision = $CollisionShape2D
@onready var timer = $Timer
@onready var sprite_bolsa = $Icon
@onready var player = $"../Player"
@onready var damage_zone = $"../damage_zone"

const time_to_grab = 3  


var counter_coin = 0 
var peso = 0
var p = self
var is_caught = false
var player_exited = false

func _ready():
	interaction_area.interact = Callable(self, "on_interact")
	print(self.position)
	
func _physics_process(_delta):
	#print("Peso de la bolsa ",peso,"kl")
	if Player.grab_input == true  :
			self.global_position = Player.pi.global_position
			freeze = true #freeze y sleeping en true le quitan la fisica a la bolsa
			sleeping=  true
	

func _input(_event):
	#if Input.is_action_just_pressed("Grab") and is_caught == true  :
		#Player.grab_input = true
		#Player.Fake_bag.show()
	if Input.is_action_just_pressed("Drop"):
		Player.grab_input = false
		freeze = false # freeze y sleeping en false le devuelven la fisica a la bolsa
		sleeping=  false
		#bolsa.colision.disabled= false
		Player.Fake_bag.hide()
		#bolsa.show()
	if Input.is_action_just_pressed("Launched") and Player.grab_input:#si grab es true ( solo para si esta agarrado)
		freeze = false # freeze y sleeping en false le devuelven la fisica a la bolsa
		sleeping=  false
		Player.grab_input = false # se deshabilita el agarrado (para asi lanzarlo)
		Player.can_throw = true # se setea en true 
		#bolsa.colision.disabled= false
		Player.Fake_bag.hide()
		show()
		if Player.grab_input == false and Player.can_throw and Player.sprite.flip_h == false :# si se cumple
			apply_impulse(Vector2(150,-450), Vector2(0,0)) #se aplica un impulso al eje x/y
		if Player.grab_input == false and Player.can_throw and Player.sprite.flip_h == true :
			apply_impulse(Vector2(-150,-450), Vector2(0,0))

func on_interact():
	DialogManager.start_dialog(global_position, lines)

 
# si la bolsa cae a una zona de daño (lava) esta hace respaw en la espalda del jugador 
#pd : para reutilizarlo hay que añadir "damage_zone" como grupo al nodo que quieras que lo use
#ejemplo :puas o yo que se ... 
func _on_area_entered(area):
	if area.is_in_group("damage_zone"):
		is_caught = true 
		Player.grab_input = true

#si el personaje toca la bolsa la agarra
func _on_body_player_entered(body):
	if body == player:
		is_caught = true 
		Player.grab_input = true



func _on_body_player_exited(body):
	if body == player:
		is_caught = false
		player_exited = true

