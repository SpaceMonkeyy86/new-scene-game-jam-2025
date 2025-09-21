extends RigidBody2D

@export var jump_velocity: float = 150
@export var max_jump_magnitude: float = 1000
@export var bonk_velocity: float = 10

var click_position = null

var hint_positions: Array[Vector2] = []
@export var num_hints: int = 5

var project_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var body_gravity = project_gravity * gravity_scale

var last_click_time: float = -1.0
var ledge_catch_window: float = 0.0
var ledge_caught: bool = false

func _physics_process(delta: float) -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()

	var colliding_ledge = false
	var colliding_ground = false

	for body in get_colliding_bodies():
		var parent = body.get_parent().name
		if parent == "Ground":
			colliding_ground = true
		elif parent.match("Ledge*"):
			colliding_ledge = true

	if not (colliding_ledge or colliding_ground or ledge_caught):
		click_position = null

	if Input.is_action_just_pressed("click"):
		last_click_time = 0.0

	if last_click_time >= 0.0:
		last_click_time += delta
			
	if Input.is_action_pressed("click"):
		if click_position == null:
			if colliding_ground:
				last_click_time = -1
				click_position = mouse_pos
				
			if colliding_ledge:
				if last_click_time >= 0 and last_click_time <= calc_ledge_window():
					last_click_time = -1
					click_position = mouse_pos
					ledge_caught = true
				else:
					last_click_time = -1
				
		if click_position and colliding_ledge:
			linear_velocity = Vector2(0, 1)
			
		if click_position and not (colliding_ledge or colliding_ground):
			click_position = null
			ledge_caught = false

	if Input.is_action_just_released("click") and click_position:
		if colliding_ground:
			jump_from(mouse_pos)
		elif colliding_ledge and ledge_caught:
			jump_from(mouse_pos)

func jump_from(mouse_pos: Vector2) -> void:
	linear_velocity = Vector2.ZERO
	apply_impulse(calc_jump_vector(click_position - mouse_pos))
	click_position = null


func calc_ledge_window() -> float:
	var speed = linear_velocity.y
	return clamp((1 - speed / 1000.0) * 0.4, 0.1, 0.7)


func _process(_delta):
	hint_positions.clear()
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	if click_position:		
		var vel = calc_jump_vector(click_position - mouse_pos)
		for i in range(num_hints):
			var t = i * 0.1
			var pos = position + vel * t + 0.5 * Vector2(0, body_gravity) * t * t
			hint_positions.append(pos)
	
	queue_redraw()

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
		draw_circle(to_local(pos), 10, Color(1, 1, 1, 0.5 + i / num_hints))
		i -= 1
