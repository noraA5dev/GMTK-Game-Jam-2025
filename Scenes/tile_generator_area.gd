extends Marker2D

const _5_WIDE = preload("res://Maps/5_wide.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	print("Test")
	var current_tile = _5_WIDE.instantiate()
	print(current_tile)
	get_tree().root.get_child(0).add_child(current_tile)
