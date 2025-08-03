extends Marker2D

const _5_WIDE = preload("res://Maps/5_wide.tscn")
@onready var world_node: Node2D = $".."

var current_instanced_tile: Marker2D = null
var current_tile: Marker2D = null
var Tile_Spacing_X: int = 50
var Tile_Spacing_Y: int = 16
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_next_tile():
	return _5_WIDE
func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	current_tile = get_next_tile().instantiate()
	world_node.add_child(current_tile)
	current_instanced_tile = world_node.get_child(-1)
	var test = get_tree().root.get_node("World/5 Wide")
	print(test.tile_spacing_x, ", ", test.tile_spacing_y)
	Tile_Spacing_X = test.tile_spacing_x * 8
	current_instanced_tile.global_position = Vector2(self.global_position.x + Tile_Spacing_X, self.global_position.y)
	self.global_position = Vector2(current_instanced_tile.global_position.x, current_instanced_tile.global_position.y)
