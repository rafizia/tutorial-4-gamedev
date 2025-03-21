extends CharacterBody2D

@onready var hearts: HBoxContainer = $health/MarginContainer/Hearts
@export var speed: int = 200
@export var gravity: int = 1200
@export var jump_speed: int = -400
var isHurt = false
var canDoubleJump = false


func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		canDoubleJump = true
		if canDoubleJump and Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
			canDoubleJump = false
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed


func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	move_and_slide()


func _process(_delta):
	if not isHurt:
		if not is_on_floor():
			$AnimatedSprite2D.play("jump")
		elif velocity.x != 0:
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
			
			
func show_win():
	$Camera2D/Win.visible = true


func take_damage():
	isHurt = true
	$AnimatedSprite2D.play("hurt")
	global.lives -=1
	await get_tree().create_timer(0.5).timeout
	isHurt = false
	if (global.lives == 0):
		get_tree().change_scene_to_file.call_deferred(str("res://scenes/GameOver.tscn"))
		global.lives = 3
	else:
		hearts.update_hearts()
