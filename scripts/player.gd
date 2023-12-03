class_name Player extends CharacterBody2D

signal spray_shot(shoot_scene, location)
signal died

@export var speed = 300

@export var shot_speed := 0.25

@onready var muzzle = $Muzzle

var shoot_scene = preload("res://scenes/shoot.tscn")

var shoot_cd := false
var hp = 3

func _ready():
	$cristal_score.transform['x'][0] = 2
	$cristal_score.transform['y'][1] = 2
	print($cristal_score.transform)


func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(shot_speed).timeout
			shoot_cd = false


func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), 
	Input.get_axis("ui_up", "ui_down"))
	velocity = direction * speed
	move_and_slide()
	
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)


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
