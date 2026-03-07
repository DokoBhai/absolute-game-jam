extends State
class_name GrapplingState

@export var ray: RayCast2D
@export var line: Line2D

@onready var color: ColorRect = get_parent().get_parent().get_parent().get_node("ColorRect")
var targetPosition: Vector2

func enter():
	line.visible = true
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)
	
	ray.look_at(subject.get_global_mouse_position())
	
	ray.force_raycast_update()
	if ray.is_colliding():
		targetPosition = ray.get_collision_point()
		color.position = targetPosition
		
func exit():
	line.visible = false

func update(_delta: float):
	if Input.is_action_just_released("mouse_left"):
		Transition.emit(self, "AirborneState")

func physics_update(delta):
	update_rope(delta)

func update_rope(delta):
	var target_dir = subject.global_position.direction_to(targetPosition)
	var distance = subject.global_position.distance_to(targetPosition)

	var displacement = distance - subject.rest_length

	var force = Vector2.ZERO

	if displacement > 0:
		var spring_force_magnitude = subject.stiffness * displacement
		var spring_force: Vector2 = target_dir * spring_force_magnitude

		var vel_dot: float = subject.velocity.dot(target_dir)
		var damping2: Vector2 = -subject.damping * vel_dot * target_dir

		force = spring_force + damping2
		force.x = clamp(force.x, -subject.max_rope_force, subject.max_rope_force)
		force.y = clamp(force.y, -subject.max_rope_force, subject.max_rope_force)
	
	line.set_point_position(0, line.get_parent().to_local(targetPosition))
	subject.velocity += force * delta
