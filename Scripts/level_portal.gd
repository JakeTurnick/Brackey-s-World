extends Node2D

@export var nextLevel : String


func _on_area_2d_body_entered(body):
	SceneManager.goto_scene(nextLevel)
