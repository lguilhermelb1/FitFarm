extends CharacterBody2D
class_name Player_1

const SPEED = 130.0

@onready var anim := $anim as AnimatedSprite2D
@onready var remote := $remote as RemoteTransform2D
@onready var animal_detector := $animal_detector as Area2D
@onready var button_capture := $button_capture as AnimatedSprite2D
@onready var pontuacao := $pontuacao as Label

@onready var cristal_score_anim := $cristal_score/anim as AnimationPlayer
@onready var cistal_score := $cristal_score as Node2D

@onready var cronometro = $Cronometro

@onready var cristals_sound := $audio/cristals_sound as AudioStreamPlayer
@onready var points_sound := $audio/points_sound as AudioStreamPlayer
@onready var collect_sound := $audio/collect_sound as AudioStreamPlayer
@onready var footsteps := $audio/footsteps as AudioStreamPlayer

var animal = null
var direction
var scores
var cristais = 0
var lt = []

func _ready():
	animal = null
	scores = 0
	button_capture.visible = false
	atualizar_placar()

func _physics_process(delta):
	print(Global.cristais)
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
	_captura_animal()
	move_and_slide()
	

func _set_animal_detector():
	
	if (direction.x > 0 and direction.y==0) or (anim.scale.x == -1):
		animal_detector.position.x = 13
		animal_detector.position.y = 0
				
	elif (direction.x < 0 and direction.y == 0) or (anim.scale.x == 1):
		animal_detector.position.x = -13
		animal_detector.position.y = 0
		
	elif direction.x == 0 and direction.y > 0:
		animal_detector.position.x = 0
		animal_detector.position.y = 13
		
	elif direction.x == 0 and direction.y < 0:
		animal_detector.position.x = 0
		animal_detector.position.y = -13
	
	elif direction.x > 0 and direction.y > 0:
		animal_detector.position.x = 12
		animal_detector.position.y = 12
	
	elif direction.x > 0 and direction.y < 0:
		animal_detector.position.x = 10
		animal_detector.position.y = -10
		
	elif direction.x < 0 and direction.y > 0:
		animal_detector.position.x = -12
		animal_detector.position.y = 12
		
	elif direction.x < 0 and direction.y < 0:
		animal_detector.position.x = -10
		animal_detector.position.y = -10
		

func _captura_animal():
	_set_animal_detector()
	
	if len(lt) == 1 and lt[0] == null:
		lt.pop_front()

	if Input.get_action_strength("ui_capture"):		
		if animal != null and len(lt) == 0:
			collect_sound.play()
			lt.append(animal)
			button_capture.visible = false
			add_collision_exception_with(animal)
			animal.setTargetlayer(get_path())


func _set_state():
	var state = "idle"
	
	if direction != Vector2.ZERO:
		state = "walk"
		
	anim.play(state)


func follow_camera(camera):
	remote.remote_path = camera.get_path()

func getDirection():
	return direction

func tem_animal():
	return len(lt) == 0

func _on_animal_detector_body_entered(body):
	if body.is_in_group("animal") and len(lt) == 0:
		button_capture.visible = true
		button_capture.play("default")	
		animal = body
		
func _on_animal_detector_body_exited(body):
	button_capture.visible = false
	animal = null

func ganhar_pontos():
	scores += 50
	
	if scores % 200 == 0:
		cristal_score_anim.play("fade_in")
		cristais += 100
		Global.cristais += 100
		cristals_sound.play()
	else:
		points_sound.play()		
	
	cronometro.set_scores(scores, cristais)
	atualizar_placar()

func atualizar_placar():
	pontuacao.text = "%08d" % scores
