extends Node2D

@export var meleeScene: PackedScene
@export var knifeScene: PackedScene
@export var rangedScene: PackedScene
@export var tankScene: PackedScene
	
var spawnsAmount: int = 1

func SpawnAnEnemy():
	var enemyToSpawn
	var enemiesList = [rangedScene]
	
	if(spawnsAmount % 8 == 0):
		enemyToSpawn = tankScene.instantiate()
	
	else:
		var rng = RandomNumberGenerator.new()
		enemyToSpawn = enemiesList[rng.randf_range(0,enemiesList.size())].instantiate()
	
	var possibleSpawnPoints = [Vector2(-151,-255), Vector2(-151,255),Vector2(-384,0), Vector2(405,0)]
	enemyToSpawn.global_position = possibleSpawnPoints.pick_random()
	get_tree().get_root().get_node("Main").add_child(enemyToSpawn)
	
	spawnsAmount += 1
	
	
func StartSpawnLoop():
	SpawnAnEnemy()
	await get_tree().create_timer(8).timeout
	StartSpawnLoop()
