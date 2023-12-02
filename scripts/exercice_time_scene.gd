extends Node2D

@onready var transition_animation := $transition/animation

# Called when the node enters the scene tree for the first time.
func _ready():
	await(transition_animation.is_playing())
	$animation.play("opening")
