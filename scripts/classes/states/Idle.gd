extends State
class_name IdleState

@export var player: CharacterBody2D

func enter():
	print("entered idle state!")

func update(_delta: float):
	if Input.is_action_just_pressed("mouse_left"):
		Transition.emit(self, "GrapplingState")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transition.emit(self, "JumpingState")
		return
	
	if Input.get_axis("move_left", "move_right") != 0:
		Transition.emit(self, "MovingState")
		
func physics_update(_delta: float):
	player.velocity.x = move_toward(player.velocity.x, 0, 100)
