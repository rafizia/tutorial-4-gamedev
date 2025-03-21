extends HBoxContainer

@export var heart_scene: PackedScene = preload("res://scenes/LifeCounter.tscn")

func _ready():
	update_hearts()

func update_hearts():
	for child in get_children():
		child.queue_free()

	for i in range(global.lives):
		var heart = heart_scene.instantiate()
		add_child(heart)
