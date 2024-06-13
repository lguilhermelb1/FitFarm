extends CharacterBody2D
class_name Player_1

const SPEED = 130

signal earn_points(scores, coins)

@onready var anim := $anim as AnimatedSprite2D
@onready var animal_detector := $animal_detector as Area2D
@onready var cristal_score_anim := $cristal_score/anim as AnimationPlayer
@onready var cistal_score := $cristal_score as Node2D
@onready var cristals_sound := $audio/cristals_sound as AudioStreamPlayer
@onready var collect_sound := $audio/collect_sound as AudioStreamPlayer
@onready var footsteps := $audio/footsteps as AudioStreamPlayer

var animal = null
var direction 
var scores
var moedas = 0
var lt = []

func _ready():
	animal = null
	scores = 0
	$cristal_score.transform['x'][0] = 1
	$cristal_score.transform['y'][1] = 1
	
	
func _input(event):
	if event is InputEventScreenDrag:
		direction = event.relative.normalized()
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
	
		

func _captura_animal(animal):	
	if animal != null:
		collect_sound.play()
		lt.append(animal)
		add_collision_exception_with(animal)
		animal.setTargetlayer(get_path())


func _set_state(state : String):
	anim.play(state)

func getDirection():
	return direction

func tem_animal():
	return len(lt) == 0


func _on_animal_detector_body_entered(body):
	if body.is_in_group("animal") and body not in lt:
		_captura_animal(body)
		ganhar_pontos()

func ganhar_pontos():
	scores += 50	
	if scores % 200 == 0:
		cristal_score_anim.play("fade_in")
		moedas += 50
		Global.moedas += 50
		cristals_sound.play()
	earn_points.emit(scores, moedas)


func progresso_perdido():
	Global.moedas -= moedas
