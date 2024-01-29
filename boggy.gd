extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0:
		_animated_sprite.flip_h = true
	elif direction > 0:
		_animated_sprite.flip_h = false
		# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		_animated_sprite.play("jump");
	elif direction > 0:
		_animated_sprite.play("walk")
	elif direction < 0:
		_animated_sprite.play("walk")
	elif direction == 0 and is_on_floor():
		_animated_sprite.play("idle");

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	move_and_slide()
	


#func _process(_delta):
	#if Input.is_action_pressed("ui_right"):
		#_animated_sprite.flip_h = false
		#_animated_sprite.play("walk")
		#print("Pressing Right");
	#if Input.is_action_pressed("ui_left"):
		#_animated_sprite.flip_h = true
		#_animated_sprite.play("walk")
		#
	#else:
		#_animated_sprite.play("idle");

