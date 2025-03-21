extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		body.take_damage()
		if (global.lives != 0):
			get_tree().call_deferred("reload_current_scene")
