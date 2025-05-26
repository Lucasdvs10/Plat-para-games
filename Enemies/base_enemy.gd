extends CharacterBody2D
@onready var agent: NavigationAgent2D = $NavigationAgent2D

@export var SPEED = 300
@export var stopDistance: float = 4
var stopDistanceSquared: float
var targetPosition: Vector2
var player: Node2D

@export var max_health: int = 100
var current_health: int

func _ready():
	stopDistanceSquared = stopDistance * stopDistance
	player = get_parent().get_node("Player")
	current_health = max_health

func _physics_process(delta: float) -> void:
	if(player == null):
		return
		
	targetPosition = player.global_position
	updateTarget(targetPosition)
	
	if(global_position.distance_squared_to(targetPosition) > stopDistanceSquared):
		var nextLocation = agent.get_next_path_position()
		var newVel = (nextLocation - global_position).normalized() * SPEED
		velocity = velocity.lerp(newVel, 7 * delta)
		move_and_slide()
	else:
		velocity = Vector2.ZERO

		

func updateTarget(targetPos: Vector2) -> void:
	agent.set_target_position(targetPos)
	
func piscar():
	for i in range(3):
		$Sprite2D.visible = false
		await get_tree().create_timer(0.1).timeout
		$Sprite2D.visible = true
		await get_tree().create_timer(0.1).timeout

func take_damage(amount: int):
	current_health -= amount
	current_health = max(current_health, 0)
	piscar()
	
	if current_health <= 0:
		die()

func die():
	queue_free()
