extends Area2D

@export var sceneName: String = "Level2"


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		TransitionScreen.transition()
		await TransitionScreen.get_node("AnimationPlayer").animation_finished
		get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
