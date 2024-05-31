class_name Player extends CharacterBody2D

signal spray_shot(shoot_scene, location)
signal died

@export var speed = 50
@export var shot_speed := 0.25
@onready var muzzle = $Muzzle

var shoot_scene = preload("res://scenes/shoot.tscn")

var shoot_cd := false
var hp = 3

func _ready():
	$cristal_score.transform['x'][0] = 2
	$cristal_score.transform['y'][1] = 2


func shoot():
	spray_shot.emit(shoot_scene, muzzle.global_position)


func die():
	died.emit()
	queue_free()


func set_cristal_score_label(value:int):
	$cristal_score/main_label/label.text = str("+ " + str(value))
	$cristal_score/anim.play("fade_in")
	$audio.play()
	await ($cristal_score/anim.animation_finished)

func _input(event):
	if event is InputEventScreenDrag: # get final position on release of mouse button
		var direction = event.relative
		velocity = Vector2(direction.x, 0) * speed
		move_and_slide()
		global_position = global_position.clamp(Vector2(20, 20), get_viewport_rect().size - Vector2(20, 20) )
	elif event is InputEventScreenTouch:
		shoot()
	if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(shot_speed).timeout
			shoot_cd = false

	
	
