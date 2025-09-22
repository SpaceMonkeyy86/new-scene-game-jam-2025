extends Node

var DEBUG = false

var debug_audio: AudioStreamPlayer = null

var powerup = preload("res://assets/sounds/powerup.mp3")
var powerdown = preload("res://assets/sounds/powerdown.mp3")

func _debug_toggle() -> void:
	if DEBUG:
		debug_audio.stream = powerdown
	else:
		debug_audio.stream = powerup
		
	debug_audio.play()
	
	DEBUG = !DEBUG

func _ready():
	debug_audio = AudioStreamPlayer.new()
	add_child(debug_audio)
