extends Area2D

func _ready() -> void:
	GlobalSignals.fall_to_death.connect(on_fall_to_death)

func _on_body_entered(body: CharacterBody2D) -> void:
	#runs when the player enters the collision zone
	on_fall_to_death()
func on_fall_to_death():
	print(r"Shrug")
