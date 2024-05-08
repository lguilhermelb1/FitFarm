extends Node2D
@export var bug_scenes: Array[PackedScene] = []

@onready var player_spawn = $PlayerSpawn
@onready var shoot_container = $ShootContainer
@onready var timer = $BugSpwanTimer
@onready var bug_container = $BugContainer
@onready var hud = $UILayer/HUD
@onready var gameOverScreen = $UILayer/GameOverScreen
@onready var animation = $UILayer/GameOverScreen/anim
@onready var exit_button = $UILayer/HUD/exit_button

@onready var transition = $UILayer/transition
@onready var shootSound = $SFX/Shoot
@onready var hitSound = $SFX/Hit

var player = null

var score := 0:
	set(value):
		score = value
		hud.score = score

var high_score
var points = 0
var cr = 0

func _ready():
	get_tree().paused = false
	get_window().size = Vector2(515, 650)

	Global.setTransition(transition)
	
	if Global.time_label == null:
		Global.createTimeLabel()
	
	print(Global.time_label)
	Global.tempo_final.start()
	print("TEMPO FINAL: ", Global.time_label)	
	
	Global.time_label.position = Vector2(170,30)
	Global.time_label.scale = Vector2(1.3, 1.3)
	Global.setLabelTime()
	print(Global.time_label.get_theme_font("empty"))
	Global.tempo_final.start()
			
	$UILayer/HUD.add_child(Global.time_label)

	print("Started")
	
	var save_file = FileAccess.open('user://save.data', FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
		
	score = 0
	player = get_tree().get_first_node_in_group("player_bug_invader")
	assert(player != null)
	player.global_position = player_spawn.global_position
	player.spray_shot.connect(_on_player_spray_shot)
	player.died.connect(_on_player_died)
	
	gameOverScreen.visible=false
	$UILayer/Comfirm_Exit.setPlayer(self)
	$UILayer/Comfirm_Exit.setTransition($UILayer/transition)
	gameOverScreen.setTransition($UILayer/transition)
		
	
func save_game():
	var save_file = FileAccess.open('user://save.data', FileAccess.WRITE)
	save_file.store_32(high_score)
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
	var e = bug_scenes.pick_random().instantiate()
	#randf_range(50, 500)
	e.global_position = Vector2(randf_range(-160, 275), 0)
	e.died.connect(_on_bug_died)
	bug_container.add_child(e)


func _on_bug_died(points):
	hitSound.play()
	score += points
	
	if score % 150 == 0:
		cr += 40
		Global.moedas += 40
		player.set_cristal_score_label(40)
	
	if score > high_score:
		high_score = score

func _on_player_died():
	gameOverScreen.set_score(score)
	gameOverScreen.set_high_score(high_score)
	save_game()
	await get_tree().create_timer(0.5).timeout		
	gameOverScreen.visible = true	
	animation.play("show_label")
	await(animation.animation_finished)


func progresso_perdido():
	Global.moedas -= cr


func _on_touch_screen_button_pressed():
	if $UILayer/GameOverScreen.visible==false:
		$UILayer/Comfirm_Exit.visible=true
		$UILayer/Comfirm_Exit/anim.play("exit_label2")
		get_tree().paused=true			
		await($UILayer/Comfirm_Exit/anim.animation_finished)
