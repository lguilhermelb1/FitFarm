extends Control

const base_speed := 70
const base_space := 30
const line_space_multiplier := 1
const section_space_multiplier := 3
var lines = []

var section




var title_color := Color.LAWN_GREEN

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

func _process(delta):
	var scroll_speed = base_speed * delta
	for child in credits_container.get_children():
		child.position.y -= scroll_speed
	
		
func add_line(n, pos):
	var new_line = line.duplicate()
	new_line.text = section[n]
	lines.append(new_line)
	if n == 0:
		new_line.set("theme_override_colors/font_color", title_color)
		
	new_line.position.y += base_space*pos
	print(new_line.position.y)
	return new_line
	
	

		
		
