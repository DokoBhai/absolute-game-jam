extends State
class_name GrapplingState

@export var ray: RayCast2D
@export var line: Line2D

@onready var color: ColorRect = get_parent().get_parent().get_parent().get_node("ColorRect")
var target_position: Vector2
var rope_length: float

func enter():
	print("entered Grappling state!")
	line.visible = true
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)
	
	ray.look_at(subject.get_global_mouse_position())
	
	ray.force_raycast_update()
	if ray.is_colliding():
		target_position = ray.get_collision_point()
		rope_length = subject.global_position.distance_to(target_position)
		color.position = target_position
		
func exit():
	line.visible = false
	var rope_dir = (subject.global_position - target_position).normalized()
	var tangential_velocity = subject.velocity - rope_dir * subject.velocity.dot(rope_dir)

	subject.velocity = tangential_velocity * 1.2

func update(_delta: float):
	if Input.is_action_just_released("mouse_left"):
		Transition.emit(self, "AirborneState")



func physics_update(delta):
	update_rope(delta)

func update_rope(_delta):
	var rope_dir = subject.global_position.direction_to(target_position)
	var distance = subject.global_position.distance_to(target_position)

	# remove velocity moving away from the anchor
	var radial_velocity = subject.velocity.dot(rope_dir)
	subject.velocity -= rope_dir * radial_velocity

	# keep player at rope length
	subject.global_position = target_position - rope_dir * rope_length
	line.set_point_position(0, line.get_parent().to_local(target_position))

func get_move_direction():
	return Input.get_axis("move_left", "move_right")
