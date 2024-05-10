extends Node

func goto_scene(scene):
	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene):
	# Load and play transition
	var transitionCanvas = ResourceLoader.load("res://Scenes/Statics/LoadingCanvas.tscn").instantiate()
	get_tree().root.add_child(transitionCanvas, false, Node.INTERNAL_MODE_FRONT)
	transitionCanvas.get_child(0).PlayFadeIn()
	await get_tree().create_timer(2.0).timeout
	# get and remove the current scene
	var current_scene = get_tree().root.get_child(-1)
	current_scene.free()
	# add next level
	var next_scene = ResourceLoader.load(scene).instantiate()
	get_tree().root.add_child(next_scene)
	# transition out and remove transition scene
	transitionCanvas.get_child(0).QueueFadeOut()
	#TODO - find a better wait to await animation length or wait till animation is done
	await get_tree().create_timer(1.0).timeout
	transitionCanvas.free()
	
func OG_gotoScene(path):
	var testabs = get_tree().root.get_node("/root/Game")
	var testrel = get_tree().root.get_node("./Game")
	#print("abs:", testabs, " rel:", testrel)
	
	var transitionCanvas = ResourceLoader.load("res://Scenes/Statics/LoadingCanvas.tscn").instantiate()
	get_tree().root.add_child(transitionCanvas, false, Node.INTERNAL_MODE_FRONT)
	transitionCanvas.get_child(0).PlayFadeIn()
	await get_tree().create_timer(2.0).timeout
	var current_scene = get_tree().root.get_node("/root/Game").get_child(0)
	# It is now safe to remove the current scene.
	current_scene.free()
	# Load the new scene.
	var nextScene = ResourceLoader.load(path).instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.get_node("/root/Game").add_child(nextScene)
	transitionCanvas.get_child(0).QueueFadeOut()
	#TODO - find a better wait to await animation length or wait till animation is done
	await get_tree().create_timer(1.0).timeout
	transitionCanvas.free()
