extends RigidBody2D

@export var jump_velocity = 600
@export var gravity = 1.0

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		linear_velocity = Vector2.ZERO
		gravity_scale = 0
	elif Input.is_action_just_released("click"):
		linear_velocity = Vector2.UP * jump_velocity
		gravity_scale = gravity
