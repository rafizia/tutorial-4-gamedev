Nama: Muhammad Rafi Zia Ulhaq<br>
NPM: 2206814551<br>

## Tilemap

![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/main/image/tilemap.png?raw=true)
Saya menggunakan tileset dari [PLATFORMER/METROIDVANIA ASSET PACK](https://o-lobster.itch.io/platformmetroidvania-pixel-art-asset-pack) di itch.io dengan ukuran 64x64.

## Spawner Arrow (Shooter)
![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/main/image/shooter.png?raw=true)
Merupakan sebuah Spawner yang menembakkan sebuah Arrow secara horizontal. Jika Player terkena Arrow tersebut maka Player akan mati dan mengulang level tersebut.
#### Penjelasan
Membuat sebuah scene baru berupa sebuah Sprite untuk menampilkan Spawner tersebut dan sebuah script untuk menembakkan Arrow.
```
@export var arrow_scene: PackedScene
@export var shoot_direction: Vector2 = Vector2.LEFT
@export var shoot_speed: float = 1000
@export var shoot_interval: float = 3.0

func _ready():
	$Timer.wait_time = shoot_interval           # mengatur waktu sesuai shoot_interval
	$Timer.start()                              # mulai timer

func _on_timer_timeout():
	var arrow = arrow_scene.instantiate() as RigidBody2D       # spawn Arrow
	arrow.global_position = global_position                    # meletakkan Arrow
	arrow.linear_velocity = shoot_direction * shoot_speed      # memberi kecepatan Arrow
	get_parent().add_child(arrow)                              # menambahkan Arrow ke dalam scene
```
`_ready()`: berisi sebuah timer untuk menembak Arrow secara berkala.<br>
`_on_timer_timeout()`: membuat objek Arrow dan menambahkan Arrow tersebut ke dalam scene.<br>
Selanjutnya membuat sebuah scene baru bertipe RigidBody untuk menampilkan Arrow dan script untuk membuat Player mati jika terkena Arrow tersebut.
![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/main/image/arrow.png?raw=true)
```
@export var speed: float = 300
@export var direction: Vector2 = Vector2.LEFT

func _physics_process(delta):
	linear_velocity = direction * speed     # mengatur kecepatan

func _on_body_entered(body: Node):
	if body.get_name() == "Player":
		get_tree().call_deferred("reload_current_scene")    # reload level
```
`_physics_process(delta)`: mengatur kecepatan Arrow tersebut.<br>
`_on_body_entered(body: Node)`: saat Arrow mengenai Player, maka level akan di reload.

## Falling Spike
![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/main/image/spike.png?raw=true)
Merupakan sebuah objek berbentuk spike yang akan jatuh ketika Player lewat di bawahnya. Player akan mati jika terkena spike tersebut.
#### Penjelasan
Membuat scene baru yang berisi sebuah Sprite untuk menampilkan gambar Spike, Area2D Hitbox sebagai trigger jika Player terkena Spike, dan Area2D PlayerDetect untuk mendeteksi Player saat lewat di bawah Spike tersebut.
```
@export var speed = 160.0
var current_speed = 0.0


func _physics_process(delta: float) -> void:
	position.y += current_speed * delta     # menjatuhkan Spike

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":        
		get_tree().call_deferred("reload_current_scene")
	
func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player": 
		$AnimationPlayer.play("fall")
		
func fall():
	current_speed = speed       # mengganti kecepatan Spike agar terjatuh
	await get_tree().create_timer(5).timeout       # tunggu 5 detik
	queue_free()                                   # hapus objek
```
`_physics_process(delta: float)`: menjatuhkan Spike sesuai kecepatan current_speed<br>
`_on_hitbox_body_entered(body: Node2D)`: jika terkena Player, maka reload level<br>
`_on_player_detect_body_entered(body: Node2D)`: mendeteksi Player saat lewat di bawahnya<br>
`fall()`: mengganti kecepatan Spike agar jatuh

## Falling Stone
![alt text](https://github.com/rafizia/tutorial-4-gamedev/blob/main/image/stone.png?raw=true)
Merupakan sebuah batu berbentuk bola yang akan jatuh dan menggelinding ketika Player lewat di bawahnya. Player akan mati jika terkena batu tersebut.
#### Penjelasan
Membuat scene baru yang berisi sebuah Sprite untuk menampilkan gambar batu, Hitbox sebagai trigger jika Player terkena batu, dan Area2D untuk mendeteksi Player saat lewat di bawah batu tersebut.
```
func _ready():
	gravity_scale = 0.0
	
func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		gravity_scale = 1.0         # mengganti nilai gravitasi
		await get_tree().create_timer(10).timeout
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.get_name() == "Player":
		get_tree().call_deferred("reload_current_scene")
```
`_ready()`: mengatur gravitasi menjadi 0 agar batu tidak jatuh<br>
`_on_area_2d_body_entered(body)`: mendeteksi Player saat lewat di bawah batu tersebut dan mengganti nilai gravitasi menjadi 1 agar batu terjatuh<br>
`_on_body_entered(body: Node)`: jika terkena Player, maka reload level


##### Referensi:
https://www.youtube.com/watch?v=p83cg4OYGAE&t=327s<br>
