extends RigidBody2D

@export var speed = 400

func _process(delta):
	print(position)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		set_axis_velocity(Vector2.ZERO)
		apply_force(Vector2.UP * speed * delta)

func _integrate_forces(state):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		state.linear_velocity = Vector2.UP * speed
