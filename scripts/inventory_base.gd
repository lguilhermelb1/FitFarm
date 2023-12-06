extends GridContainer

# OBS: não tinha dado certo criar um prefab para o slot
# então eu instanciei dentro mesmo
var inventory = [
	{
		name = "goat",
		price = 250,
		payment="coin",
		scale=1,
		icon_scale=0.85,
		path = "res://assets/Inventory_Items/goat.png" 
	},
	
	{
		name = "chicken",
		price = 40,
		payment="cristal",
		scale=0.15,
		icon_scale=0.85,		
		path = "res://assets/Inventory_Items/chicken.png" 
	},
	
	{
		name = "Broccoli",
		price = 30,
		payment="cristal",
		scale=0.15,
		icon_scale=0.85,		
		path = "res://assets/Inventory_Items/Broccoli.png" 
	},
	
	{
		name = "Carrot",
		price = 20,
		payment="coin",
		scale=1,		
		icon_scale=0.85,
		path = "res://assets/Inventory_Items/Carrot.png" 
	},
	
	{
		name = "Potato",
		price = 20,
		payment="cristal",
		scale=0.15,
		icon_scale=0.85,		
		path = "res://assets/Inventory_Items/Potato.png" 
	},
	
	{
		name = "Coin",
		price = 300,
		payment="cristal",
		scale=0.15,
		icon_scale=2,		
		path = "res://assets/Objects/Payment/coin.png" 
	},
	
	{
		name = "Barn",
		price = 0,
		payment="cristal",
		scale=0.15,
		icon_scale=0.15,
		path = "res://assets/Objects/celeiro.png" 
	}
]


func main_update():
	for x in len(inventory):
		_update_slot(x)
	
	if get_child_count() % 2 == 1 and get_child_count() > 2:
		custom_minimum_size[1] = 50 * (get_child_count() - 2)
	else:
		custom_minimum_size[1] = 50 * (get_child_count()/2)

func _update_slot(pos):
	var slt = load("res://prefab/slot.tscn").instantiate()
	
	slt.get_node("icon").texture = load(inventory[pos]['path'])
	slt.get_node("icon").transform[0][0] = inventory[pos]['icon_scale']
	slt.get_node("icon").transform[1][1] = inventory[pos]['icon_scale']
	
	slt.get_node("pagamento").texture = load("res://assets/Objects/Payment/" 
										 + inventory[pos]['payment'] + ".png")
										
	slt.set_pagamento(inventory[pos]['payment'])									
	slt.get_node("pagamento").transform[0][0] = inventory[pos]['scale']
	slt.get_node("pagamento").transform[1][1] = inventory[pos]['scale']
	
	slt.get_node("preco").text = str(inventory[pos]['price'])
	add_child(slt)


func _on_exit_store_button_pressed():
	get_parent().get_parent().hide()
