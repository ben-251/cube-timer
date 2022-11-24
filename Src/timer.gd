extends Label

class t:
	pass

func _ready():
	#save_file("3x3","")
	text = "0.00"
	
var timing = false
var time_elapsed = 0.0
var about_to_time = false

	


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
			times += prep_digits(time_elapsed)+"\n"
			save_file("3x3",times)
			#update_time_list()

		else:
			about_to_time = true
			
	if about_to_time && event.is_action_released("start_timer"):	
		time_elapsed = 0.0
		about_to_time = false
		timing = true


func str_to_list(string):
	var arr = []
	for character in string:
		arr.append(character)
	return arr

func get_decimal_digits(num):
	var number = str(num)
	var decimal_found = false
	var digits = ""

	for character in number:
		if character == ".":
			decimal_found = true
		if decimal_found:
			digits += character
	return digits

func is_whole_num(number):
	for character in number:
		if character != ".":
			continue
		if character != "0":
			return false
	return true

func prep_digits(num):
	var number = stepify(num,0.01)
	number = str(number)
	
	var decimal_digits = get_decimal_digits(number)
	
	if is_whole_num(number):
		number += ".00"
	else:
		for i in range(2-len(decimal_digits)):
			number += "0"
		
	
	return number
	
func _process(delta):
	if timing:
		time_elapsed += delta
		var number = prep_digits(time_elapsed)
		text = number
