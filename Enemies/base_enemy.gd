extends CharacterBody2D
@onready var agent: NavigationAgent2D = $NavigationAgent2D

@export var SPEED = 300
@export var stopDistance: float = 4
var stopDistanceSquared: float
var targetPosition: Vector2

func _ready():
	stopDistanceSquared = stopDistance * stopDistance

func _physics_process(delta: float) -> void:
	targetPosition = get_parent().get_node("Player").global_position
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
