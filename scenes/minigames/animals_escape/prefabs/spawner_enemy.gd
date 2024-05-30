extends Node

@onready var timer := $timer as Timer

var animal1 =  null
var animal2 = null
var animal = null

var qual_animal = 0
var qual_velocidade=0

# Called when the node enters the scene tree for the first time.
func _ready():
	animal1 = preload("res://actors/goat.tscn") 
	animal2 = preload("res://actors/chicken.tscn")
	timer.wait_time = 3
	criar_animal()
	timer.start()

func _on_timer_timeout():
	criar_animal()

func criar_animal():
	qual_animal = randi() % 2
	
	if qual_animal == 0:
		animal = animal1.instantiate()
	elif qual_animal == 1:
		animal = animal2.instantiate()

	animal.script = load("res://scenes/minigames/animals_escape/prefabs/animal_controller.gd")
	
	qual_velocidade = randi() % 3
	
	if qual_velocidade == 0:
		animal.setSpeed(10)
	elif qual_velocidade == 1:
		animal.setSpeed(100)
	elif qual_velocidade == 2:
		animal.setSpeed(1000)

	add_child(animal)
