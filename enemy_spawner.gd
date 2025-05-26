extends Node2D

@export var meleeScene: PackedScene
@export var knifeScene: PackedScene
@export var rangedScene: PackedScene
@export var tankScene: PackedScene
	

func SpawnAnEnemy():
	var enemyToSpawn = meleeScene.instantiate()
	
	enemyToSpawn.global_position = Vector2(-151,-255)
	get_tree().get_root().get_node("Main").add_child(enemyToSpawn)
	
	
func StartSpawnLoop():
	SpawnAnEnemy()
	await get_tree().create_timer(5).timeout
	StartSpawnLoop()
