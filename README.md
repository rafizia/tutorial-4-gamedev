Nama: Muhammad Rafi Zia Ulhaq<br>
NPM: 2206814551

## Halaman Game Over

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/game_over.png?raw=true)
Halaman ini menampilkan sebuah Label Game Over dan juga LinkButton YES dan NO untuk memberi pilihan pemain untuk melanjutkan permainan atau tidak. Jika pemain memilih YES, maka game akan restart dari level 1, sedangkan jika pemain memilih NO, maka pemain akan kembali ke menu utama.

#### Penjelasan

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/game_over_structure.png?raw=true)
Scene GameOverPage terdiri dari sebuah Node2D background, Label GameOver, Label PlayAgain, HBoxContainer yang berisi LinkButton YES dan NO, serta TileMap. Terdapat juga script pada pada masing-masing LinkButton untuk menangani _event handler_ ketika pemain menekan tombol tersebut:

```
# Kode untuk LinkButton YES

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file(str("res://scenes/Level1.tscn"))
```

`_on_pressed()`: restart game dari level 1.

```
# Kode untuk LinkButton NO

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file(str("res://scenes/MainMenu.tscn"))
```

`_on_pressed()`: kembali ke menu utama.

## Halaman Stage Select

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/stage_select.png?raw=true)
Halaman ini menampilkan sebuah LinkButton pilihan level yaitu level 1 dan level 2, serta sebuah LinkButton BackButton untuk kembali ke menu utama.

#### Penjelasan

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/stage_select_structure.png?raw=true)
Scene StageSelectPage terdiri dari sebuah Node2D background, HBoxContainer yang berisi LinkButton Level 1 dan Level 2, LinkButton BackButton, serta TileMap. Terdapat juga script pada pada masing-masing LinkButton untuk menangani _event handler_ ketika pemain menekan tombol tersebut:

```
# Kode untuk LinkButton Level 1

@export var sceneName: String = "Level1"

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
```

`_on_pressed()`: memilih level 1.

```
# Kode untuk LinkButton Level 2

@export var sceneName: String = "Level2"

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
```

`_on_pressed()`: memilih level 2.

```
# Kode untuk LinkButton Back

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file(str("res://scenes/MainMenu.tscn"))
```

`_on_pressed()`: kembali ke menu utama.

## Transisi Antar Scene

Merupakan sebuah scene untuk menampilkan transisi dari suatu scene ke scene lain.

#### Penjelasan

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/transition_scene.png?raw=true)
Scene TransitionScreen terdiri dari sebuah ColorRect dan sebuah AnimationPlayer. Terdapat juga script untuk scene ini yaitu:

```
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	color_rect.visible = false

func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
```

`transition()`: mengubah visibility color_react dan memainkan animasi transisi.<br>
`_on_animation_player_animation_finished()`: dijalankan saat animasi transisi selesai.

## Life Heart

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/heart.png?raw=true)
Merupakan sebuah scene yang merepresentasikan jumlah HP pemain. Masing-masing gambar hati merepresentasikan 1 HP pemain. Jika pemain terkena damage maka HP pemain akan berkurang 1.

#### Penjelasan

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/tutorial-6/image/heart_structure.png?raw=true)
Scene Hearts merupakan sebuah scene dengan type HBoxContainer yang terdiri dari sebuah TextureRect dengan gambar hati. Terdapat juga sebuah script untuk Player ketika player terkena damage:

```
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
```

`take_damage()`: fungsi ini akan dipanggil setiap kali pemain terkena damage, ketika pemain terkena damage maka akan mengurangi HP pemain (global.lives) sebanyak 1 HP. Jika HP pemain 0 maka tampilkan scene GameOver. Jika HP pemain tidak sama dengan 0 maka panggil fungsi `update_heart` pada scene Heart tadi untuk meng-update tampilan HP pemain. Berikut merupakan script untuk meng-update tampilan HP pemain:

```
@export var heart_scene: PackedScene = preload("res://scenes/LifeCounter.tscn")

func _ready():
	update_hearts()

func update_hearts():
	for child in get_children():
		child.queue_free()

	for i in range(global.lives):
		var heart = heart_scene.instantiate()
		add_child(heart)
```

`update_hearts()`: tambahkan child yaitu sebuah TextureRect bergambar hati sesuai dengan jumlah HP pemain, jika pemain memiliki 3 HP maka tampilkan 3 buah gambar hati.

##### Referensi:

https://youtu.be/Shj_QVwrefY?si=iEGpwhqhzJWhTvRu<br>
