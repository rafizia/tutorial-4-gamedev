extends Node2D

@export var speed = 160.0
var current_speed = 0.0


func _physics_process(delta: float) -> void:
	position.y += current_speed * delta

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		get_tree().call_deferred("reload_current_scene")
	
func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player": 
		$AnimationPlayer.play("fall")
		
func fall():
	current_speed = speed
	await get_tree().create_timer(5).timeout
	queue_free()
