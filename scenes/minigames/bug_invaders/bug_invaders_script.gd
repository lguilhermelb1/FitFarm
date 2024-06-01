extends Node2D
@export var bug_scenes: Array[PackedScene] = []

@onready var player_spawn = $PlayerSpawn
@onready var shoot_container = $ShootContainer
@onready var timer = $BugSpwanTimer
@onready var bug_container = $BugContainer
@onready var hud = $UILayer/HUD
@onready var gameOverScreen = $UILayer/GameOverScreen
@onready var animation = $UILayer/GameOverScreen/anim
@onready var background_image = $BackgroundImage
@onready var transition = $UILayer/transition
@onready var shootSound = $SFX/Shoot
@onready var hitSound = $SFX/Hit
@onready var player = %Player



var score := 0:
	set(value):
		score = value
		hud.score = score

var high_score
var points = 0
var cr = 0

func _ready():
	get_tree().paused = false
	
	# Muda o tamanho do background de acordo com o tamanho da tela, 
	#porque Node2D não tem tamanho e não aceita ancorar na tela toda
	_on_viewport_size_change()
	get_viewport().connect("size_changed", _on_viewport_size_change)
	
	#Coloca o jogador no meio/inferior da tela
	spawn_player()
	
	_create_time_label()

	Global.setTransition(transition)
	score = 0

	player.spray_shot.connect(_on_player_spray_shot)
	player.died.connect(_on_player_died)
	
	gameOverScreen.visible=false
	$UILayer/Comfirm_Exit.setPlayer(self)
	$UILayer/Comfirm_Exit.setTransition($UILayer/transition)
	gameOverScreen.setTransition($UILayer/transition)
		
	
func save_game():
	Global.att_db()
	
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	if timer.wait_time > 0.5:
		timer.wait_time -= _delta * 0.005
	elif timer.wait_time < 0.5:
		timer.wait_time = 0.5

func _on_player_spray_shot(shoot_scene, location):
	var shoot = shoot_scene.instantiate()
	shoot.global_position = location
	shoot_container.add_child(shoot)
	shootSound.play()


func _on_bug_spwan_timer_timeout():
	var viewport_size = get_viewport_rect().size
	var e = bug_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(20, viewport_size.x - 20), 0)
	e.died.connect(_on_bug_died)
	bug_container.add_child(e)


func _on_bug_died(points):
	if(player != null and !player.is_queued_for_deletion()):
		hitSound.play()
		score += points
		
		if score % 100 == 0:
			cr += 10
			Global.moedas += 10
			player.set_cristal_score_label(10)


func _on_player_died():
	gameOverScreen.set_score(score)
	gameOverScreen.set_high_score(cr)
	save_game()
	await get_tree().create_timer(0.5).timeout		
	gameOverScreen.visible = true	
	animation.play("show_label")
	await(animation.animation_finished)


func progresso_perdido():
	Global.moedas -= cr

func _on_viewport_size_change():
	_set_background_size()
	_set_player_spawnwer_pos()
	if(player != null and !player.is_queued_for_deletion()):
		player.global_position.y = player_spawn.global_position.y
	
	

func _set_background_size():
	var viewport_size = get_viewport_rect().size
	background_image.set_size(viewport_size)

func _set_player_spawnwer_pos():
	var viewport_size : Vector2 = get_viewport_rect().size
	var x = viewport_size.x/2
	var y = viewport_size.y - 200
	player_spawn.global_position = Vector2(x,y)

func spawn_player():
	player.global_position = player_spawn.global_position

func _on_hud_exit_button_pressed():
	if $UILayer/GameOverScreen.visible==false:
		$UILayer/Comfirm_Exit.visible=true
		$UILayer/Comfirm_Exit/anim.play("exit_label2")
		get_tree().paused=true			
		await($UILayer/Comfirm_Exit/anim.animation_finished)

func _create_time_label():
	var viewport_size : Vector2 = get_viewport_rect().size
	if Global.time_label == null:
		Global.createTimeLabel()
	Global.tempo_final.start()
	Global.time_label.scale = Vector2(1.3, 1.3)
	var x = viewport_size.x - 260 - 20
	Global.time_label.position = Vector2(x, 50)
	Global.setLabelTime()		
	$UILayer/HUD.add_child(Global.time_label)


	
