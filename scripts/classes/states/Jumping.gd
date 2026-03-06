extends State
class_name JumpingState

@export var player: CharacterBody2D
@export var MOVE_SPEED := 100
@export var JUMP_VELOCITY = -300.0

func enter():
	print("entered Jumping state!")
	player.velocity.y = JUMP_VELOCITY

func update(_delta: float):
	if player.is_on_floor():
		Transition.emit(self, "IdleState")

func physics_update(_delta: float):
	var direction = get_move_direction()
	player.velocity.x = direction * MOVE_SPEED

func get_move_direction():
	return Input.get_axis("move_left", "move_right")
