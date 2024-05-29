extends Control

const base_speed := 200
const base_space := 30
const line_space_multiplier := 2
const section_space_multiplier := 4


var section
var finished = false
var stop_point



var title_color = Color("#ffec1f")

@onready var line = %Line
@onready var credits_container = $Panel/ColorRect/CreditsContainer

var credits = [
	[
		"Game Design",
		"Isís Ximenes"
	],[
		"Programadores",
		"Luis Guilherme",
		"Rodrigo Franco", 
		"Ingrid Moreira"
			
	],[
		"UI",
		"Isís Ximenes",
		"Luis Guilherme"
	],[
		"Level Design",
		"Luis Guilherme",
		"Rodrigo Franco",
	],[
		"Programador de Redes",
		"Luis Guilherme",
	],[
		"Escritor",
		"Isís Ximenes", 
		"Luis Guilherme",
		"Rodrigo Franco", 
		"Ingrid Moreira"
	],[
		"Techinical Artist ",
		"Isís Ximenes"
	],[
		"Audio Designer", 
		"Isís Ximenes", 
		"Luis Guilherme",
		"Rodrigo Franco", 
		"Ingrid Moreira"
	]
]

func _ready():
	var pos = 1;
	for i in range(credits.size()):
		section = credits[i]
		for n in range(section.size()):
			if n == 0:
				pos+=section_space_multiplier
			else: 
				pos+=line_space_multiplier
			credits_container.add_child(add_line(n, pos))
	stop_point = credits_container.position.y + credits_container.get_size().y/2
	
func _process(delta):
	if not finished:
		var scroll_speed = base_speed * delta
		var lines = credits_container.get_children()
		for i in range(lines.size()):
			lines[i].position.y -= scroll_speed
			if(i == lines.size() - 1 and lines[i].position.y < stop_point ):
				finished = true
				
		
		
func add_line(n, pos):
	var new_line = line.duplicate()
	new_line.text = section[n]
	if n == 0:
		new_line.set("theme_override_colors/font_color", title_color)	
	new_line.position.y += base_space*pos
	return new_line


	

		


func _on_texture_button_pressed():
	get_tree().change_scene_to_file(Global.LOGIN_SCREEN_SCENE)
