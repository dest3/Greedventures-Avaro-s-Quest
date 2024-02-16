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
	print(sprite_bolsa.scale)#para que veas en consola  que si aumenta el scale 
	
	
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


func _on_area_entered(_area):
	if Player.is_in_group("player"):#area para detectar si entro el personaje y asi que pueda 
		#agarrar la bolsa 
		is_caught = true 
		Player.grab_input = true


func _on_area_exited(_area):
	if Player.is_in_group("player"):
		is_caught = false
		player_exited = true
	

