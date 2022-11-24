extends Control

var object = InnerClass.new()

class InnerClass:
	#member variables
	var another = 100
   
	func getAnother():
		return another

func _ready():
	var getInnerValue = object.getAnother()
	print(getInnerValue)
