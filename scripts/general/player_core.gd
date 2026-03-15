extends CharacterBody2D

@export_group("Movement Settings")
@export var movement_speed = 100
@export var acceleration = 0.1
@export var deceleration = 0.1
@export var jump_velocity = -300
@export var air_resistance = 2.0

@export_group("Grappling Settings")
@export var pull_strength = 1
@export var max_rope_force = 6000
@export var max_velocity = 10000

# will probably have to add more later
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
