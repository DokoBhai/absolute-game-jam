extends State
class_name JumpingState

func enter():
	print("entered Jumping state!")
	subject.velocity.y = subject.jump_velocity

func update(_delta: float):
	if Input.is_action_just_pressed("mouse_left"):
		Transition.emit(self, "GrapplingState")
	
	if Input.is_action_just_pressed("mouse_right"):
		Transition.emit(self, "LaunchingState")
	
	if subject.is_on_floor():
		Transition.emit(self, "MovingState")

func physics_update(_delta: float):
	var direction = get_move_direction()
	subject.velocity.x = direction * subject.movement_speed

func get_move_direction():
	return Input.get_axis("move_left", "move_right")
