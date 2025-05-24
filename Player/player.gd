extends CharacterBody2D

@export var bullet_scene: PackedScene
@export var speed: float = 200.0
@export var max_health: int = 100

var current_health: int
var isInvincible: bool = false

func _ready():
	current_health = max_health

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()

func _process(delta):
	if $HealthBar:
		$HealthBar.value = current_health

func take_damage(amount: int):
	if isInvincible:
		return

	current_health -= amount
	current_health = max(current_health, 0)
	print("Tomei dano")

	if current_health <= 0:
		die()

	isInvincible = true
	await piscar()
	isInvincible = false

func piscar():
	for i in range(3):
		$Sprite2D.visible = false
		await get_tree().create_timer(0.1).timeout
		$Sprite2D.visible = true
		await get_tree().create_timer(0.1).timeout

func die():
	queue_free()
	print("Morri")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot_bullet()

func shoot_bullet():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		
		var mouse_pos = get_global_mouse_position()
		var dir = (mouse_pos - global_position).normalized()
		var offset_distance = 16
		
		var shoot_origin = global_position + dir * offset_distance
		
		bullet.global_position = shoot_origin
		bullet.direction = dir
		bullet.rotation = dir.angle()
		
		bullet.owner = self
		
		get_parent().add_child(bullet)
		
		print("Disparo da posição:", shoot_origin, "em direção a:", dir)
