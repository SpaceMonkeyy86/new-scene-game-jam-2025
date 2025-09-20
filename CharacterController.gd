extends RigidBody2D

@export var jump_velocity: float = 3
@export var gravity: float = 1.0
@export var camera_panning: float = 0.3
@export var camera_reset_speed: float = 20

var click_position = null

func _process(_delta):
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()

	if click_position:
		$Camera2D.offset = (mouse_pos - click_position) * camera_panning
	else:
		$Camera2D.offset = $Camera2D.offset.move_toward(Vector2.ZERO, camera_reset_speed)

	if Input.is_action_just_pressed("click"):
		linear_velocity = Vector2.ZERO
		gravity_scale = 0
		click_position = mouse_pos
	elif Input.is_action_just_released("click") and click_position:
		linear_velocity = -(mouse_pos - click_position) * jump_velocity
		gravity_scale = gravity
		click_position = null
