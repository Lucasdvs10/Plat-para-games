extends CharacterBody2D
@onready var agent: NavigationAgent2D = $NavigationAgent2D

@export var SPEED = 300
@export var stopDistance: float = 4
var stopDistanceSquared: float
var targetPosition: Vector2
var player: Node2D

@export var max_health: int = 100
var current_health: int = max_health

func _ready():
	stopDistanceSquared = stopDistance * stopDistance
	player = get_parent().get_node("Player")

func _physics_process(delta: float) -> void:
	if(player == null):
		printerr("Player não encontrado na árvore de Nodes")
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
	
	

func take_damage(amount: int):
	current_health -= amount
	current_health = max(current_health, 0)
	print("Tomei dano")
	if current_health <= 0:
		die()

func die():
	#player.enemy_spawner
	queue_free()
