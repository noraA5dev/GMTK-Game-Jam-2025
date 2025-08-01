extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_plane: Area2D = $"../Death Plane"


@export var MAX_SPEED := 300
@export var JUMP_VELOCITY := -350
var SPEED = 0
var ACCELERATION = 500
var lastX = 0
var lastY = 0
var on_ladder: bool
var climbing: bool

func _ready() -> void:
	#GlobalSignals.fall_to_death.connect(on_fall_to_death)
	#print(death_plane.global_position)
	pass

func flip(direction):
	if direction == -1:
		return true
	else:
		return false

func _physics_process(delta: float) -> void:
	var did_move = (lastX == position.x) and (lastY == position.y)
	var direction := Input.get_axis("left", "right")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handles respawn/ restart
	if Input.is_action_just_pressed("restart"):
		velocity = Vector2(0, 0)
		death()
	# Get the input direction and handle the movement/deceleration.
	$Camera2D/Label.text = "velocity: " + str(velocity) + "\n SPEED: " + str(SPEED) + "\ndirection: " + str(direction)
	if direction: # Adjust the threshold (0.1) as needed:
		$AnimatedSprite2D.flip_h = flip(direction)
		if did_move:
			SPEED = min(SPEED + ACCELERATION * delta, MAX_SPEED)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		SPEED = 0
		

	move_and_slide()

	#detection for if the player has moved
	lastX = position.x
	lastY = position.y

func death():
	anim.play("Death")
	print(r"¯\_(ツ)_/¯ You ded")
	get_tree().reload_current_scene()

func _on_death_plane_body_entered(_body: CharacterBody2D) -> void:
	death()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	on_ladder = false
	pass # Replace with function body.

func _on_area_2d_body_entered(_body: Node2D) -> void:
	on_ladder = true
	pass # Replace with function body.
