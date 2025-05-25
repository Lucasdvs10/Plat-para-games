extends Node2D

@export var meleeEnemy: PackedScene
@export var knifeEnemy: PackedScene
@export var rangedEnemy: PackedScene
@export var tankEnemy: PackedScene
@export var enemiesDied: int = 0

var enemiesTypeList = [meleeEnemy, knifeEnemy, rangedEnemy]

func SpawnAnEnemy():
	if(enemiesDied % 5 == 0):
		tankEnemy.instantiate()
	
	#var enemyToSpawn = enemiesTypeList.pick_random()
	#var kappa = enemyToSpawn.instantiate()
	#kappa.global_position = Vector2(100,100)

func _ready():
	SpawnAnEnemy()
