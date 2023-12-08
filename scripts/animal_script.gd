extends CharacterBody2D


@onready var anim := $anim as AnimationPlayer
@onready var sprite := $sprite as Sprite2D
@onready var collision := $collision as CollisionShape2D
@onready var footsteps := $footsteps as AudioStreamPlayer
@onready var actions := $actions as Timer


var direction: Vector2 = Vector2.ZERO
var main_avoid_position: Vector2
var SPEED = 5
var rd 

func _ready():
	create_action()
	
		
func _process(delta):
	if !actions.is_stopped():		
		if rd == 0:
			direction.x = 1
			direction.y = 0
		elif rd == 1:
			direction.x = -1
			direction.y = 0
		elif rd == 2:
			direction.y = 1
			direction.x = 0
		elif rd == 3:
			direction.y = -1
			direction.x = 0
		else:
			direction = Vector2.ZERO
		
		velocity = direction * SPEED
		
		if velocity != Vector2.ZERO and !footsteps.playing:
			footsteps.play()
		
		move_and_slide()
		_set_animation()


func _set_animation():
	var state = ""
	
	if direction.y > 0:
		state = "front"
	
	elif direction.y < 0:
		state = "back"
	
	elif direction.x < 0:
		state = "left"
		
	elif direction.x > 0:
		state = "right"
		
	if velocity == Vector2.ZERO:
		state = "sleep"
		
	anim.play(state)


func _on_actions_timeout():
	create_action()


func create_action():
	rd = randi() % 4
	if rd == 4:
		actions.wait_time = 10
	else:
		actions.wait_time = 5
	
	actions.start()
