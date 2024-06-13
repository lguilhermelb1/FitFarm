extends CharacterBody2D
class_name Main_Player

const SPEED = 130

@onready var anim := $anim as AnimatedSprite2D
@onready var remote := $remote as RemoteTransform2D

@onready var cristals_sound := $audio/cristals_sound as AudioStreamPlayer
@onready var points_sound := $audio/points_sound as AudioStreamPlayer
@onready var collect_sound := $audio/collect_sound as AudioStreamPlayer
@onready var footsteps := $audio/footsteps as AudioStreamPlayer
var direction

func _ready():
	_set_state("idle")
	Global.setTransition($camera/transition)
	
func _set_state(state : String):
	anim.play(state)

	
func _input(event):
	if event is InputEventScreenDrag:
		var direction = event.relative.normalized()
		velocity = direction * SPEED
		if direction.x > 0:
			anim.scale.x = -1
		elif direction.x < 0:
			anim.scale.x = 1	
		velocity = direction * SPEED
		_set_state("walk")
		move_and_slide()
	if event is InputEventScreenTouch:
		var state = "idle"
		if(event.is_pressed()):
			footsteps.play()
			state = "walk"
		else:
			footsteps.stop()
		_set_state(state)
			
