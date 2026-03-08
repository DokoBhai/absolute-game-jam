extends State
class_name AirborneState

func enter():
	print("entered Airborne State")

func  physics_update(delta: float):
	var speed = abs(subject.velocity.x)
	var friction_strength = subject.air_resistance * speed
	subject.velocity.x = move_toward(subject.velocity.x, get_move_direction() * subject.movement_speed, friction_strength * delta)
	
	#if subject.velocity.x > move_speed:
		#subject.velocity.x = move_toward(subject.velocity.x, get_move_direction() * move_speed, horizontal_damp * 10 * delta)
	#else:
		#subject.velocity.x = get_move_direction() * move_speed

func update(_delta: float):
	if Input.is_action_just_pressed("mouse_left"):
		Transition.emit(self, "GrapplingState")
	
	if subject.is_on_floor():
		Transition.emit(self, "IdleState")

func get_move_direction():
	return Input.get_axis("move_left", "move_right")
