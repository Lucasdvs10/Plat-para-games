extends Node2D

var player

var mainNode: CharacterBody2D
var isAttacking: bool

func _ready():
	mainNode = get_parent()

	player = get_parent().get_parent().get_node("Player")
	if(player == null):
		printerr("Player não encontrado na árvore de Nodes")
	
func _process(delta: float) -> void:
	if(player == null):
		return
	if(global_position.distance_squared_to(player.global_position) <= mainNode.stopDistanceSquared && !isAttacking):
		Attack()

func Attack():
	if(player == null):
		return
	var oldVel = mainNode.SPEED
	isAttacking = true
	mainNode.SPEED = Vector2.ZERO
	
	await get_tree().create_timer(1.5).timeout
	if(player == null):
		return
	if(global_position.distance_squared_to(player.global_position) <= mainNode.stopDistanceSquared - 5):
		player.take_damage(10)
	
	mainNode.SPEED = oldVel
	isAttacking = false
