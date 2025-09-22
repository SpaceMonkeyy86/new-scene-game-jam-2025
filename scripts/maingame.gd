extends Node2D

func _ready() -> void:
	$KonamiCode.success.connect(SingleEntry._debug_toggle)
