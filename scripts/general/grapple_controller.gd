extends Node2D

@export var rest_length = 10.0
@export var stiffness = 20.0
@export var damping = 2.0

@onready var ray := $RayCast2D
@onready var player := get_parent()
@onready var rope := $Line2D
var launched = false
var target: Vector2

func _process(delta: float) -> void:
	ray.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("mouse_left"):
		launch()
	if Input.is_action_just_released("mouse_left"):
		retract()
	
	if launched:
		handle_grapple(delta)
		rope.visible = true
	else:
		rope.visible = false
	
func launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()

func retract():
	launched = false

func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var distance = player.global_position.distance_to(target)

	var displacement = distance - rest_length

	var force = Vector2.ZERO

	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude

		var vel_dot = player.velocity.dot(target_dir)
		var damping2 = -damping * vel_dot * target_dir

		force = spring_force + damping2

	player.velocity += force * delta
	update_rope()

func update_rope():
	rope.set_point_position(0, to_local(target))
