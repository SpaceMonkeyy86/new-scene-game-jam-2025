extends Node2D

@export var ledge_scene: PackedScene = preload("res://ledge.tscn")

var active_ledges: Array[Node2D] = []

func _init() -> void:
	for i in range(10):
		spawn_ledge(i)

func spawn_ledge(height: int) -> void:
	if not ledge_scene:
		print("No ledge scene")
		return
	var ledge = ledge_scene.instantiate()
	ledge.name = "Ledge" + str(height)
	add_child(ledge)
	print("Added ledge: ", ledge.name)

	var random_y = randf_range(-50, 50)
	ledge.position = Vector2(0, height * -200 + random_y)
	ledge.scale = Vector2(140.64, 2.68)

	active_ledges.append(ledge)
