extends Node2D

var player

var mainNode: CharacterBody2D
var isAttacking: bool
@export var attackDelayInSeconds: float

func _ready():
	mainNode = get_parent()

	player = get_parent().get_parent().get_node("Player")
	printerr("Player não encontrado na árvore de Nodes")
	
func _process(delta: float) -> void:
	if(player == null):
		return
	if(global_position.distance_squared_to(player.global_position) <= mainNode.stopDistanceSquared && !isAttacking):
		Attack()

func Attack():
	var oldVel = mainNode.SPEED
	isAttacking = true
	mainNode.SPEED = Vector2.ZERO
	
	await get_tree().create_timer(attackDelayInSeconds).timeout
	
	if(global_position.distance_squared_to(player.global_position) <= mainNode.stopDistanceSquared):
		player.take_damage(10)
	
	mainNode.SPEED = oldVel
	isAttacking = false
