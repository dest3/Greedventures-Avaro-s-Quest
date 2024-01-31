extends Node

var nivel1 = load("res://assets/sounds/Nivel_1.mp3")

func play_music():
	$music.stream = nivel1
	$music.play()


func stop_music():
	$music.stop()
