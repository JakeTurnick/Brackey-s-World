extends Node

@onready var score_label = $"Score Label"

var score = 0

func add_point():
	score += 1
	score_label.text = "You've collected " + str(score) + " coins!"
