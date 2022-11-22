extends Label

func _ready():
	#save_file("3x3","")
	text = str(0.0)
	
var timing = false
var time_elapsed = 0.0
var about_to_time = false

func update_time_list():	
	var timer_grid = get_parent().get_parent().get_node("times").get_child(0)
	
	var new_time = Label.new()
	timer_grid.add_child(new_time)
	timer_grid.get_children()[-1].text = str(stepify(time_elapsed,0.01))
	

func file_to_list(file_name):
	var file_content = load_file("3x3")
	var times = []
	
	var current_num = ""
	for character in file_content:
		if character != "\n":
			current_num += character
		else:
			times.append(float(current_num))
			current_num = ""	
	return times

func calculate_average(arr, sample_size):
	arr.invert()
	var total = 0
	for i in range(sample_size):
		total += arr[sample_size]
	var avg = total/sample_size
	return avg

func update_ao5(times):
	calculate_average(times, 5)
	var ao5 = get_parent().get_parent().get_node("averages").get_child(1).get_child()
	
	var new_ao5 = Label.new()
	timer_grid.add_child(new_time)
	timer_grid.get_children()[-1].text = str(stepify(time_elapsed,0.01))
	

func update_averages(file_name):
	var times = file_to_list(file_name)
	if len(times) > 12:
		#update_ao12(times)
		update_ao5(times)
	elif len(times) > 5:
		update_ao5(times)

func save_file(name, contents):
	var file = File.new()
	var error = file.open("user://" + name, File.WRITE)
	if error == OK:
		file.store_string(contents)
	else:
		print("Error opening file!")

func load_file(name):
	var file = File.new()
	var error = file.open("user://" + name, File.READ)
	if error == OK:
		var file_contents = file.get_as_text()
		return file_contents
	else:
		print("Error opening file!")
	file.close()

func _input(event):
	if event.is_action_pressed("stop_timer"):
		if timing:
			timing = false
			var times = load_file("3x3")
			times += str(stepify(time_elapsed,0.01))+"\n"
			save_file("3x3",times)
			#save_file("3x3",str(time_elapsed)+"\n")
			update_averages("3x3")
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
