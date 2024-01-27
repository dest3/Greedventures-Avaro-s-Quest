extends "res://scripts/player/state.gd"

#variables del dash
var dash_direction = Vector2.ZERO #direccion
var dash_speed = 240 # velocidad 
var dashing = false #esta dasheando 
@export var dash_duration = .2 #cuando dura
@onready var DashDuration_timer = $DashDuration #referencia al nodo timer

#si no esta dasehando entra al estado FALL
func update(_delta):
	if !dashing:
		return STATES.FALL
	return null


#cuando entra al estado no puede volver a dashear hasta tocar el suelo
func enter_state():
	Player.sprite.play("dash")
	Player.can_dash = false #no puede volver a dashear
	dashing = true #esta dasheando
	DashDuration_timer.start(dash_duration)#activa el timer del dash
	#aca abajo guarda la direccion del jugador al precionar dash y sino asigna la ultima guardada
	if Player.movement_input != Vector2.ZERO:
		dash_direction = Player.movement_input
	else:
		dash_direction = Player.last_direction
	Player.velocity = dash_direction.normalized() * dash_speed #aplica el dash con la direccion normalizada 

func exit_state():
	dashing = false #no puede volver a dashear
	
func _on_timer_timeout():
	dashing = false #no puede volver a dashear

