extends LinkButton

@export var sceneName: String = "Level2"


func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
