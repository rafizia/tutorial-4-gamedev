extends Area2D


@export var sceneName: String = "Level 1"


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
		
