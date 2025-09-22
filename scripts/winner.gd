extends Control

var winner = preload("res://assets/sounds/cheer.mp3")
var happy = preload("res://assets/sounds/happy.mp3")

func _ready():
	$AudioStreamPlayer2D.stream = winner
	$AudioStreamPlayer2D.play()
	$Button.pressed.connect(_onclick)
	
func _onclick():
	print("Restarting")
	SingleEntry.DEBUG = false
	get_tree().change_scene_to_file("res://scenes/maingame.tscn")
	queue_free()
	
func _process(delta: float) -> void:
	if $WHITE.color.a > 0:
		$WHITE.color.a -= 0.01
	else:
		$WHITE.visible = false
	
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = happy
		$AudioStreamPlayer2D.play()
