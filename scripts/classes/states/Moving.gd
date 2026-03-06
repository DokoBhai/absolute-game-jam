extends State
class_name MovingState

@export var player: CharacterBody2D
@export var MOVE_SPEED := 100

func enter():
	print("entered moving state!")

func update(_delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transition.emit(self, "JumpingState")

func physics_update(_delta: float):
	var direction = get_move_direction()
	if direction == 0:
		Transition.emit(self, "IdleState")
		return
		
	player.velocity.x = direction * MOVE_SPEED

func get_move_direction():
	return Input.get_axis("move_left", "move_right")
