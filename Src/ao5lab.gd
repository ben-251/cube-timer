extends Control
	
var timing = false
var time_elapsed = 0.0
var about_to_time = false

func _ready():
	pass

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

func update_average(file_name):
	var times = file_to_list(file_name)
	if len(times) > 12:
		#update_ao12(times)
		update_ao5(times)
	elif len(times) > 5:
		update_ao5(times)

func calculate_average(inputs, sample_size):
	var arr = inputs.duplicate(true)
	arr.invert()
	var total = 0
	for i in range(sample_size):
		total += arr[i]
	var avg = total/sample_size
	return avg

func set_average_text(avg):
	var string
	var colon_found = false
	var current_average = ""
	
	for character in self.text:
		if character != ":":
			colon_found = true
		if colon_found:
			current_average += character
			
			
			
			
			
	if len(self.text)>=8:
		string = self.text.substr(0,len(self.text)-4)
	else:
		string = self.text
	self.text = "ao5: " + avg

func update_ao5(times):
	var avg = str(stepify(calculate_average(times, 5),0.01))
	set_average_text(avg)
	pass
	
func file_to_list(file_name):
	var file_content = load_file(file_name)
	var times = []
	
	var current_num = ""
	for character in file_content:
		if character != "\n":
			current_num += character
		else:
			times.append(float(current_num))
			current_num = ""	
	return times

func _input(event):
	if event.is_action_pressed("stop_timer"):
		if timing:
			timing = false
			update_average("3x3")

		else:
			about_to_time = true
			
	if about_to_time && event.is_action_released("start_timer"):	
		time_elapsed = 0.0
		about_to_time = false
		timing = true
