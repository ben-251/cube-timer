extends Control

func set_anchors():
	self.anchor_right = 1
	self.anchor_top = 0.5
	self.anchor_bottom = 1

func _ready():
	set_anchors()
