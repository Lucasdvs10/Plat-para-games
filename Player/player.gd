extends CharacterBody2D

@export var speed: float = 200.0
@export var max_health: int = 100
var current_health: int = max_health
var isInvincible: bool

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
	if(isInvincible):
		return
		
	current_health -= amount
	current_health = max(current_health, 0)
	print("Tomei dano")
	if current_health <= 0:
		die()
	isInvincible = true
	
	for i in range(4):
		$Sprite2D.visible = false
		await get_tree().create_timer(0.25).timeout
		$Sprite2D.visible = true
		await get_tree().create_timer(0.25).timeout
		
	isInvincible = false	

func die():
	queue_free()
	print("Morri")
