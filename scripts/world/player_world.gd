extends CharacterBody2D
class_name Main_Player

const SPEED = 130.0

@onready var anim := $anim as AnimatedSprite2D
@onready var remote := $remote as RemoteTransform2D

@onready var cristals_sound := $audio/cristals_sound as AudioStreamPlayer
@onready var points_sound := $audio/points_sound as AudioStreamPlayer
@onready var collect_sound := $audio/collect_sound as AudioStreamPlayer
@onready var footsteps := $audio/footsteps as AudioStreamPlayer

@onready var Global := $Global
var direction


func _physics_process(delta):
	
	direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	if direction.x > 0:
		anim.scale.x = -1
	elif direction.x < 0:
		anim.scale.x = 1
			
	velocity = direction * SPEED
	
	if velocity == Vector2.ZERO:
		footsteps.play()
		
	_set_state()
	move_and_slide()


func _set_state():
	var state = "idle"
	
	if direction != Vector2.ZERO:
		state = "walk"
		
	anim.play(state)


func follow_camera(camera):
	remote.remote_path = camera.get_path()


func getGlobal():
	return Global
