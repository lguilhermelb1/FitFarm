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
		price = 30, # 20
		payment="coin",
		scale=.9,
		icon_scale=0.5,
		path = "res://assets/Inventory_Items/Carrot.png" 
	},
	
	{
		name = "Potato",
		price = 20, 
		payment="cristal",
		scale=0.1,
		icon_scale=0.8,		
		path = "res://assets/Inventory_Items/Potato.png" 
	},
	
	{
		name = "Cristal",
		price = 400,
		payment="coin",
		scale=.9,
		icon_scale=.2,		
		path = "res://assets/Objects/Payment/cristal.png" 
	},
	
	{
		name = "Barn",
		price = 1000,
		payment="cristal",
		scale=0.1,
		icon_scale=0.11,
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
	slt.set_icon(inventory[pos]['path'])
	slt.set_payment(inventory[pos]['price'],inventory[pos]['payment'])									

	add_child(slt)



