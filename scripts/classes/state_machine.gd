extends Node2D
class_name StateMachine

var current_state: State
var states: Dictionary
@export var initial_state: State

# will probably have to change later for enemies
@export var subject: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.subject = subject
			child.Transition.connect(on_transition)
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_transition(state: State, target_state_name: String):
	if target_state_name == current_state.name:
		return

	var new_state = states[target_state_name.to_lower()]
	if !new_state:
		return
	if !current_state:
		return
	
	state.exit()
	current_state = new_state
	new_state.enter()
	
