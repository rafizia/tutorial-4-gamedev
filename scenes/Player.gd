extends CharacterBody2D

@export var speed: int = 200
@export var gravity: int = 1200
@export var jump_speed: int = -400
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
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
			

func show_win():
	$Camera2D/Win.visible = true
