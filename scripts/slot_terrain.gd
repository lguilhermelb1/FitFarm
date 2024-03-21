extends Node2D

@export_category("Condições")
@export var type_payment_asset: Texture2D
@export var preco = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	print(type_payment_asset)
	#$Control/type_payment.texture = type_payment_asset
	#$Control/insuficiente.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
