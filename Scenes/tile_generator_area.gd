extends Marker2D

@onready var world_node: Node2D = $".."
@onready var map_num: int = $".".map_number
var maps = {1: preload("res://Maps/5_wide.tscn"),
			2: preload("res://Maps/map_2.tscn")}
var current_instanced_tile = maps[1]
var current_tile = null
var Tile_Spacing_X: int = 50*8
@export var map_number = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_next_tile():
	#return maps[map_num]["pre"]
	var keys = maps.keys()
	var random_index = randi() % keys.size()
	var random_key = keys[random_index]
	var random_value = maps[random_key]
	return random_value

func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	
	#print(maps)
	#print(map_num)
	current_tile = get_next_tile().instantiate()
	world_node.add_child(current_tile)
	current_instanced_tile = world_node.get_child(-1)
	
	
	#maps[map_num]["node"] = get_tree().root.get_node(maps[map_num]["node_tree"])
	#var test = maps[map_num]["node"]
	#print(test)
	
	# debug
	print(current_tile)
	print(current_instanced_tile)
	
	Tile_Spacing_X = current_instanced_tile.tile_spacing_x * 8 
	print(Tile_Spacing_X)
	
	current_instanced_tile.global_position = Vector2(self.global_position.x + Tile_Spacing_X, self.global_position.y)
	self.global_position = Vector2(current_instanced_tile.global_position.x, current_instanced_tile.global_position.y)
