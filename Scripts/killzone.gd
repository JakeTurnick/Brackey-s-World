extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	body.get_node("CollisionShape2D").queue_free()
	body.get_node("GoombaBoots").get_node("CollisionShape2D").queue_free()
	body.get_node("AnimatedSprite2D").play("die")
	Engine.time_scale = 0.3
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
