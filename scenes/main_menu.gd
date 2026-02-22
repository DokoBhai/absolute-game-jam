extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_down() -> void:
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")
	print("PLAY")


func _on_play_toggled(toggled_on: bool) -> void:
	print("play")
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
