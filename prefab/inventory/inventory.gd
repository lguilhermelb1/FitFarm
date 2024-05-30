extends Control
signal store_closed

func _ready():
	%GridContainer.main_update()



func _on_exit_store_button_pressed():
	store_closed.emit()

