extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


const MAX_SPEED = 300.0
const JUMP_VELOCITY = -300.0
var SPEED = 0
var ACCELERATION = 500
var lastX = 0
var lastY = 0
var direction := Input.get_axis("left", "right")

@onready var death_plane: Area2D = $"../Death Plane"

func _ready() -> void:
	#GlobalSignals.fall_to_death.connect(on_fall_to_death)
	#print(death_plane.global_position)
	pass

func flip():
	if direction == -1:
		return true
	else:
		return false

func _physics_process(delta: float) -> void:
	var did_move = (lastX == position.x) and (lastY == position.y)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	$AnimatedSprite2D.flip_h = bool(flip())

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	$Camera2D/Label.text = "velocity: " + str(velocity) + "\n SPEED: " + str(SPEED) + "\ndirection: " + str(direction)
	if direction: # Adjust the threshold (0.1) as needed:
		if did_move:
			SPEED = min(SPEED + ACCELERATION * delta, MAX_SPEED)
		velocity.x = direction * SPEED
		print("The player did move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		SPEED = 0
		print("The player did not move")
		

	move_and_slide()
	lastX = position.x
	lastY = position.y
func death():
	anim.play("Death")
	print(r"¯\_(ツ)_/¯ You ded")
	get_tree().reload_current_scene()


func _on_death_plane_body_entered(body: Node2D) -> void:
	death()
