extends CharacterBody2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_floor = $RayCastFloor

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 60
var Direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if ray_cast_right.is_colliding():
		Direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		Direction = 1
		animated_sprite_2d.flip_h = false
	position.x += Direction * SPEED * delta

	move_and_slide()
