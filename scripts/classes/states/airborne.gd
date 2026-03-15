extends State
class_name AirborneState

@onready var timer = $Timer
var move: bool = false

func enter():
	print("entered Airborne State")
	move = false
	timer.start(.15)

func  physics_update(delta: float):
	# air drag
	var speed = abs(subject.velocity.x)
	var drag = 2 * speed
	#subject.velocity.x = move_toward(subject.velocity.x, 0, drag * delta)

	# player air control
	if move:
		var direction = get_move_direction()
		var target = direction * subject.movement_speed
		subject.velocity.x = move_toward(
			subject.velocity.x,
			target,
			600 * delta
		)

func update(_delta: float):
	if Input.is_action_just_pressed("mouse_left"):
		Transition.emit(self, "GrapplingState")
	
	if Input.is_action_just_pressed("mouse_right"):
		Transition.emit(self, "LaunchingState")
	
	if subject.is_on_floor():
		Transition.emit(self, "IdleState")

func get_move_direction():
	return Input.get_axis("move_left", "move_right")


func _on_timer_timeout() -> void:
	move = true
