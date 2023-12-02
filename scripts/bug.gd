class_name Bug extends Area2D

signal died(points)

@export var speed = 150
@export var hp = 1
@export var points = 100
	
func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func take_damage(hit):
	hp -= hit
	if hp <= 0:
		died.emit(points)
		die()
