extends TextureProgressBar

@onready var char: RigidBody2D = get_node("/root/Scene1/Character")

func _process(delta: float) -> void:
	var prog = absf(char.position.y - 225.5) / (12500 + 225.5)
	value = prog * 100.0
