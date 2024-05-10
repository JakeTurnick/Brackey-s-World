extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer
@onready var held_jump_timer = $HeldJumpTimer

# Coyote time variables
var coyoteJump = false
var coyoteTime = false
var hasJumped = false

# held jump variables - holding leads to longer jump
var boostJump = false

const SPEED = 130.0
const INITIAL_JUMP_VELOCITY = -250.0
const BOOST_JUMP_VELOCITY = -9.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor(): # Add the gravity.
		velocity.y += gravity * delta
	else: # player is on floor - eligible for coyote jump
		hasJumped = false
		coyoteTime = true
	
	if is_on_ceiling():
		boostJump = false
	# Coyote Time check
	if !is_on_floor() and !hasJumped and coyoteTime:
		coyoteJump = true
		coyoteTime = false # prevents constant timer reset
		coyote_timer.start()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyoteJump):
		velocity.y = INITIAL_JUMP_VELOCITY
		hasJumped = true
		boostJump = true
		held_jump_timer.start()
	# Hold jump for bigger jump
	if Input.is_action_pressed("jump") and boostJump:
		velocity.y += BOOST_JUMP_VELOCITY
	# continually increase y velocity 
	# get input direction - 1, 0, -1
	var direction = Input.get_axis("move_left", "move_right")
	
	# flip animation to match direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_goomba_boots_body_entered(body):
	velocity.y = -200
	body.get_node("AnimatedSprite2D").play("die")
	body.position.y += 100
	var enemyAnimationTimer = get_tree().create_timer(2.0)
	await enemyAnimationTimer.timeout
	body.queue_free()

func _on_coyote_timer_timeout():
	coyoteJump = false
	coyoteTime = false


func _on_held_jump_timer_timeout():
	boostJump = false
