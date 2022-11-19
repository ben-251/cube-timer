extends Label

func _ready():
	text = str(0.0)
	

var timing = false
var time_elapsed = 0.0
var about_to_time = false


func save_time(session):
	var file_name = "res://times/"+session+".tres"
	var session_times = load(file_name) 
	var session_entry = str(time_elapsed)
	
	var file = File.new()
	file.open(file_name, File.WRITE)
	file.store_string(session_times+"\n"+session_entry)
	file.close()


func load(file_name):
	var file = File.new()
	file.open(file_name, File.READ)
	var content = file.get_as_text()
	file.close()
	return str(content)

func update_time_list():
	var timer_grid = get_parent().get_parent().get_node("times").get_child(0)
	var new_time = Label.new()
	timer_grid.add_child(new_time)
	timer_grid.get_children()[-1].text = str(time_elapsed)
	
	
func _input(event):
	if event.is_action_pressed("stop_timer"):
		if timing:
			timing = false
			#save_time("3x3")
			update_time_list()
		else:
			about_to_time = true
			
	if about_to_time && event.is_action_released("start_timer"):	
		time_elapsed = 0.0
		about_to_time = false
		timing = true

func is_whole_num(number):
	for character in number:
		if character != ".":
			continue
		if character != "0":
			return false
	return true
	
func prep_digits(number):
	number = str(number)
	if is_whole_num(number):
		number += ".0"
	while number.length() < 4 and not is_whole_num(number):
		number += "0"
	return number
	
func _process(delta):
	if timing:
		time_elapsed += delta
		var number = stepify(time_elapsed,0.01)
		number = prep_digits(number)
		text = number
