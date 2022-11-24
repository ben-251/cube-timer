extends GridContainer

func _ready():
	pass
	
func update_time_list():	
	var timer_grid = get_parent().get_parent().get_node("times").get_child(0)
	
	#var new_time = Label.new()
	#timer_grid.add_child(new_time)
	#timer_grid.get_children()[-1].text = prep_digits()
