extends State
class_name LaunchingState

@onready var timer = $Timer
@export var ray: RayCast2D
@export var line: Line2D

@onready var color: ColorRect = get_parent().get_parent().get_parent().get_node("ColorRect")

func enter():
	print("Launching")
	timer.start(.15)
	
	line.visible = true
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)
	
	ray.look_at(subject.get_global_mouse_position())
	
	ray.force_raycast_update()
	if ray.is_colliding():
		var anchor = ray.get_collision_point()

		var offset = anchor - subject.global_position
		var direction = offset.normalized()
		var distance = offset.length()

		var speed = min(distance * subject.pull_strength, 1000)
		subject.velocity = direction * speed
		
		Transition.emit(self, "AirborneState")
	else:
		Transition.emit(self, "AirborneState")	
		

func _on_timer_timeout() -> void:
	pass
	#line.visible = false
