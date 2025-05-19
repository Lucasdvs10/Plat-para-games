extends CharacterBody2D
@onready var agent: NavigationAgent2D = $NavigationAgent2D

var SPEED = 300
var targetPosition: Vector2

func _ready():
	targetPosition = Vector2(500,200)
	updateTarget(targetPosition)

func _physics_process(delta: float) -> void:
	if(global_position.distance_squared_to(targetPosition) > 4):
		var nextLocation = agent.get_next_path_position()
		var newVel = (nextLocation - global_position).normalized() * SPEED
		velocity = velocity.lerp(newVel, 7 * delta)
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func updateTarget(targetPos: Vector2) -> void:
	agent.set_target_position(targetPos)
