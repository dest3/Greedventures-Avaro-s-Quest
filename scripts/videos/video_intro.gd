extends Control


@onready var video_stream_player = $VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/environment/level_1.tscn")


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/environment/level_1.tscn")
