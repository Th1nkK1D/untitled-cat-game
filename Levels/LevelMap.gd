tool
extends GridMap


const TilePlain = preload("res://Objects/Tile.tscn")
const TileSplit = preload("res://Objects/SplitTile.tscn")
const TileExit = preload("res://Objects/ExitDoor.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var used_coords = get_used_cells()
	for coord in used_coords:
		var grid_item = get_cell_item(coord.x, coord.y, coord.z)
		print(mesh_library.get_item_name(grid_item))
		var world_coord = map_to_world(coord.x, coord.y, coord.z)
		var tile
		
		match mesh_library.get_item_name(grid_item):
			"Plain":
				tile = TilePlain.instance()
			"SplitLeft":
				tile = TileSplit.instance()
			"Exit":
				tile = TileExit.instance()
		
		tile.translation = world_coord
		add_child(tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
