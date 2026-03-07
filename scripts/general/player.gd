extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 0.1
const DECELERATION = 0.1

@onready var gc = $GrappleController

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") && (is_on_floor() || gc.launched):
		velocity.y += JUMP_VELOCITY
		gc.retract()

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = lerp(velocity.x, SPEED * direction, ACCELERATION)
		print(velocity.x)
	else:
		velocity.x = lerp(velocity.x, SPEED * direction, DECELERATION)
		print(velocity.x)
	if Input.is_action_pressed("move_down") && is_on_floor():
		$Sprite2D.scale.y = 0.05
	else:
		$Sprite2D.scale.y = 0.1

	move_and_slide()
