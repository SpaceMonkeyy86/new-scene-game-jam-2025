extends RigidBody2D

@export var jump_velocity: float = 150
@export var max_jump_magnitude: float = 1000
@export var camera_panning: float = 0.3
@export var camera_reset_speed: float = 20
@export var bonk_velocity: float = 10

var click_position = null

var hint_positions: Array[Vector2] = []
@export var num_hints: int = 5

var project_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var body_gravity = project_gravity * gravity_scale

func _process(_delta):
	hint_positions.clear()
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	if click_position:
		$Camera2D.offset = (mouse_pos - click_position) * camera_panning
		
		var vel = calc_jump_vector(click_position - mouse_pos)
		for i in range(num_hints):
			var t = i * 0.1
			var pos = position + vel * t + 0.5 * Vector2(0, body_gravity) * t * t
			hint_positions.append(pos)
	else:
		$Camera2D.offset = $Camera2D.offset.move_toward(Vector2.ZERO, camera_reset_speed)
	
	queue_redraw()
	
	if Input.is_action_just_pressed("click"):
		var ledge = false
		for body in get_colliding_bodies():
			print(body)
			if body.find_parent("Ledge") or body.find_parent("Wall"):
				ledge = true
				break
		if ledge:
			linear_velocity = Vector2.ZERO
			freeze = true
			click_position = mouse_pos
		else:
			linear_velocity.x = maxf(linear_velocity.x, bonk_velocity)
			linear_velocity.y = bonk_velocity
	
	elif Input.is_action_just_released("click") and click_position:
		freeze = false
		linear_velocity = Vector2.ZERO
		apply_impulse(calc_jump_vector(click_position - mouse_pos))
		click_position = null

func calc_jump_vector(offset: Vector2) -> Vector2:
	var v = offset
	v.x = log(absf(v.x)+1) * (-1 if v.x < 0 else 1)
	v.y = log(absf(v.y)+1) * (-1 if v.y < 0 else 1)
	v *= jump_velocity
	if v.length() > max_jump_magnitude:
		v = v.normalized() * max_jump_magnitude
	return v

func _draw():
	var i: float = num_hints
	for pos in hint_positions:
		draw_circle(to_local(pos), 10, Color(1, 1, 1, i / num_hints))
		i -= 1
