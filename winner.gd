extends Control

func _ready():
	$Button.pressed.connect(_onclick)
	
func _onclick():
	print("Restarting")
	get_tree().change_scene_to_file("res://scene_1.tscn")
	queue_free()
