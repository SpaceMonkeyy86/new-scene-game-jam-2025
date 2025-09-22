extends Control

var winner = preload("res://assets/sounds/crowd-cheer-applause-victory-fanfare-clapping-236698 (1).mp3")
var happy = preload("res://assets/sounds/happy-kids-background-music-364459.mp3")

func _ready():
	$AudioStreamPlayer2D.stream = winner
	$AudioStreamPlayer2D.play()
	$Button.pressed.connect(_onclick)
	
func _onclick():
	print("Restarting")
	get_tree().change_scene_to_file("res://scenes/maingame.tscn")
	queue_free()
	
func _process(delta: float) -> void:
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = happy
		$AudioStreamPlayer2D.play()
