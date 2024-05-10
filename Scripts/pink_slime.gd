extends CharacterBody2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_upper_left = $RayCastUpperLeft
@onready var ray_cast_upper_right = $RayCastUpperRight
@onready var ray_cast_floor_left = $RayCastFloorLeft
@onready var ray_cast_floor_right = $RayCastFloorRight

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 60
var Direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# check for walls
	# if wall - jump if wall is 1 tile high, else turn around
	if ray_cast_right.is_colliding():
		if !ray_cast_upper_right.is_colliding():
			velocity.y += -30
		else:
			Direction = -1
			animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		if !ray_cast_upper_left.is_colliding():
			velocity.y += -30
		else:
			Direction = 1
			animated_sprite_2d.flip_h = false
	# check for pit fall, turn around if fall is too large
	if !ray_cast_floor_left.is_colliding():
		Direction = 1
		animated_sprite_2d.flip_h = false
	if !ray_cast_floor_right.is_colliding():
		Direction = -1
		animated_sprite_2d.flip_h = true
	
	position.x += Direction * SPEED * delta

	move_and_slide()
