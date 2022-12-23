extends TileMap


const FLOOR = preload("res://src/environment/burglar_base_world/tiles/floor/Floor.tscn")

func replace_tiles_with_instances():
	replace(FLOOR, 0)

func delete_tiles(tile_objects: TileMap):
	var occupied_tiles = tile_objects.get_occupied_cells()
	for tile in occupied_tiles:
		set_cell(tile.x, tile.y, -1)
		

func replace(INSTANCE, id: int):
	var tile_pos
	var tiles = get_used_cells_by_id(id)
	for tile in tiles:
		var new_instance = INSTANCE.instance()
		tile_pos = map_to_world(tile)
		tile_pos.x += cell_size.x / 2
		tile_pos.y += cell_size.y
		new_instance.set_position(tile_pos)
		set_cell(tile.x, tile.y, -1)
		Global.entity_world.add_child(new_instance)
