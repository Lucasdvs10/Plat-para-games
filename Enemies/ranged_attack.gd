extends Node2D
var player: Node2D
var baseEnemy: CharacterBody2D
var attackDistanceSqr
var isAttacking:bool = false
@export var bullet_scene: PackedScene

func _ready():
	player = get_parent().get_parent().get_node("Player")
	baseEnemy = get_parent()
	attackDistanceSqr = baseEnemy.stopDistanceSquared
	
func _process(delta: float) -> void:
	if(player == null):
		return
		

	if(
		#global_position.distance_squared_to(player.global_position) <= attackDistanceSqr && 
		!isAttacking):
		shoot_bullet()

func shoot_bullet():
	if bullet_scene:
		isAttacking = true
		baseEnemy = get_parent()
		
		var bullet = bullet_scene.instantiate()
		
		var player_pos = player.global_position
		var dir = (player_pos - baseEnemy.global_position).normalized()
		var offset_distance = 16
		
		var shoot_origin = baseEnemy.global_position + dir * offset_distance
		
		bullet.global_position = shoot_origin
		bullet.direction = dir
		bullet.rotation = dir.angle()
		
		get_parent().get_parent().add_child(bullet)
		
		await get_tree().create_timer(1).timeout
		
		isAttacking = false
