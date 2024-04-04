extends GridContainer

# OBS: não tinha dado certo criar um prefab para o slot
# então eu instanciei dentro mesmo
var inventory = [
	{
		name = "goat",
		price = 40,
		payment="coin",
		scale=.9,
		icon_scale=.7,
		path = "res://assets/Inventory_Items/goat.png" 
	},
	
	{
		name = "chicken",
		price = 40,
		payment="cristal",
		scale=0.1,
		icon_scale=.9,
		path = "res://assets/Inventory_Items/chicken.png" 
	},
	
	{
		name = "Broccoli",
		price = 30, # 30
		payment="cristal",
		scale=0.1,
		icon_scale=0.5,		
		path = "res://assets/Inventory_Items/Broccoli.png" 
	},
	
	{
		name = "Carrot",
		price = 0, # 20
		payment="coin",
		scale=.9,
		icon_scale=0.5,
		path = "res://assets/Inventory_Items/Carrot.png" 
	},
	
	{
		name = "Potato",
		price = 0, # 20
		payment="cristal",
		scale=0.1,
		icon_scale=0.8,		
		path = "res://assets/Inventory_Items/Potato.png" 
	},
	
	{
		name = "Coin",
		price = 300,
		payment="cristal",
		scale=0.1,
		icon_scale=1.5,		
		path = "res://assets/Objects/Payment/coin.png" 
	},
	
	{
		name = "Barn",
		price = 0, #10000
		payment="cristal",
		scale=0.1,
		icon_scale=0.11,
		path = "res://assets/Objects/celeiro.png" 
	},

]


func main_update():
	for x in len(inventory):
		_update_slot(x)
	
	if get_child_count() <= 4:
		custom_minimum_size[1] = 50
	else:
		custom_minimum_size[1] = (68 + 35* ((get_child_count()/4)-1))


	#if get_child_count() % 4 == 1 and get_child_count() > 4:
	#	custom_minimum_size[1] = 68 * (get_child_count() - 4)
	#else:
		#custom_minimum_size[1] = (68 * (get_child_count()/4))
	#	custom_minimum_size[1] = (68 + 30* ((get_child_count()/4)-1))


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
