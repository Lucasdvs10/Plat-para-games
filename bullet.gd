extends Area2D

@export var speed: float = 200.0
@export var durationInSeconds: float = 200.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	$CollisionShape2D.set_deferred("disabled", false)
	$Timer.start()
#
func _process(delta):
	global_position += direction * (speed * delta)

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(20)
	queue_free()
