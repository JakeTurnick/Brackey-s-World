extends Camera2D

@export var BottomLimit : int = 1000

func _ready():
	set_limit(SIDE_BOTTOM, BottomLimit)
