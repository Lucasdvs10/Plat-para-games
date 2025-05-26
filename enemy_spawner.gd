extends Node2D

@export var meleeScene: PackedScene
@export var knifeScene: PackedScene
@export var rangedScene: PackedScene
@export var tankScene: PackedScene
	
func SpawnAnEnemy():
	var enemyToSpawn = meleeScene.instantiate()
	
	enemyToSpawn.global_position = Vector2(100,100)
	get_tree().get_root().add_child(enemyToSpawn)
	
	
#func _process(delta: float) -> void:
	#await get_tree().create_timer(2).timeout
	#SpawnAnEnemy()
