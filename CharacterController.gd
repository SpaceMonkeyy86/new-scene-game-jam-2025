extends RigidBody2D

@export var jump_multiplier: float = 150
@export var max_jump_magnitude: float = 1000
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
		freeze = true
		click_position = mouse_pos
	elif Input.is_action_just_released("click") and click_position:
		freeze = false
		linear_velocity = Vector2.ZERO
		apply_impulse(calc_jump_vector(click_position - mouse_pos))
		click_position = null

func calc_jump_vector(offset: Vector2) -> Vector2:
	var v = offset
	v.x = log(absf(v.x)+1) * (-1 if v.x < 0 else 1)
	v.y = log(absf(v.y)+1) * (-1 if v.y < 0 else 1)
	v *= jump_multiplier
	if v.length() > max_jump_magnitude:
		v = v.normalized() * max_jump_magnitude
	return v
	
