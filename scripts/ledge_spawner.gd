extends Node2D

@export var ledge_scene: PackedScene = preload("res://scenes/ledge.tscn")

var ledges: Array[Texture2D] = [
	preload("res://assets/ledges/ledge1.png"),
	preload("res://assets/ledges/ledge2.png"),
	preload("res://assets/ledges/ledge3.png"),
	preload("res://assets/ledges/ledge4.png")
]

var ledge_sizes: Array[Vector2] = [
	Vector2(5, 5),
	Vector2(5, 5),
	Vector2(5, 5),
	Vector2(5, 5)
]

var active_ledges: Array[Node2D] = []

func _init() -> void:
	for i in range(100):
		spawn_ledge(i)

func spawn_ledge(height: int) -> void:
	if not ledge_scene:
		print("No ledge scene")
		return
	var ledge = ledge_scene.instantiate()
	ledge.name = "Ledge" + str(height)
	ledge.visible = true
	add_child(ledge)
	print("Added ledge: ", ledge.name)

	var random_y = randf_range(-50, 50)
	ledge.position = Vector2(randf_range(-500, 500), height * -200 + random_y)
	ledge.scale = ledge_sizes[height % 4]

	
	var sprite = ledge.find_child("Sprite2D")
	sprite.texture = ledges[height % 4]

	active_ledges.append(ledge)
