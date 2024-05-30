extends CharacterBody2D

@onready var anim := $anim as AnimationPlayer
@onready var sprite := $sprite as Sprite2D
@onready var collision := $collision as CollisionShape2D
@onready var footsteps := $footsteps as AudioStreamPlayer

var direction: Vector2 = Vector2(position.x, position.y)
var target: Player_1
var pego = false
var main_avoid_position: Vector2
var SPEED = 100

func _ready():
	pego = false


# o animal teria que se mover com base na direcao do usuário
func setTargetlayer(path:String):
	target = get_node(path)
	set_collision_mask_value(1, false)
	pego = true

# x (+= 0.1) direita
# x (-= 0.1) esquerda
# y (+= 0.1) cima
# y (-= 0.1) baixo

func _basic_movement():
	direction.x += 0.01
	velocity = direction * SPEED


func _follow_player():
	var tgt_position = (target.position - global_position).normalized()
	direction = tgt_position
	
	if global_position.distance_to(target.position) < 25:
		velocity = Vector2.ZERO
	
	if global_position.distance_to(target.position) >= 25:
		velocity = tgt_position * global_position.distance_to(target.position)
		direction = target.getDirection()


#func _run_away():
	#var oposite_position =  (global_position - main_avoid_position).normalized()
	#print("Distance: ", oposite_position)

#	if global_position.distance_to(main_avoid_position) >= 120:
	#	main_avoid_position = Vector2.ZERO
	#else:
		#var x_ou_y = randi() % 2
		
		#if x_ou_y == 0 and oposite_position.x < 0:
		#	direction.x += 0.01
		#elif x_ou_y == 0 and oposite_position.x > 0:
		#	direction.x -= 0.01
	
		# duvida em escolher a direção
		#direction = oposite_position 
		#velocity = oposite_position * SPEED
		#direction = target.getDirection()

func _physics_process(delta):	
	if pego == true:
		_follow_player()
	else:
		_basic_movement()
	
	if velocity != Vector2.ZERO and !footsteps.playing:
		footsteps.play()
	
	move_and_slide()
	_set_animation()

func _set_animation():
	var state = " "
	
	if direction.y > 0:
		state = "front"
	
	elif direction.y < 0:
		state = "back"
	
	elif direction.x < 0:
		state = "left"
		
	elif direction.x > 0:
		state = "right"
		
	anim.play(state)


func setSpeed(spd):
	SPEED = spd


func _on_deteccao_body_entered(body):
	if body.name == "player":
		main_avoid_position = body.position
		print("BODY: ", body.name, "/", body.position, "/",
		global_position.direction_to(body.position).normalized())


func _on_deteccao_area_entered(area):
	if area.name == "insercao" and pego == false:
		main_avoid_position = area.position
		print("Area: ", area.name, "/", area.position, "/",
		global_position.direction_to(area.position))


func _on_deteccao_area_exited(area):
	if area.name == "remocao":
		print("Removido")
