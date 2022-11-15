extends Label

func _ready():
	text = str(0.0)
	

var timing = false
var time_elapsed = 0.0


func _input(event):
	if event.is_action_released("start_timer"):	
		timing = true
	if event.is_action_pressed("stop_timer"):
		timing = false
		time_elapsed = 0.0

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
		var number = stepify(time_elapsed,0.1)
		#number = prep_digits(number)
		text = number
