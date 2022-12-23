extends TileMap


#const security_camera = preload("res://test folder/stick.png")

const ENEMY_GUNNER = preload("res://src/entities/enemies/BurglarEnemyGunner/BurglarEnemyGunner.tscn")
const TEST_BOX = preload("res://src/environment/burglar_base_world/tiles/TestBox.tscn")
const TEST_DOOR = preload("res://src/environment/burglar_base_world/tiles/doors/base_door/BaseDoor.tscn")
const SECURITY_CAMERA = preload("res://src/environment/burglar_base_world/tiles/security_camera/SecurityCamera.tscn")
const SHADOW = preload("res://src/environment/burglar_base_world/tiles/shadow/Shadow.tscn")
const TEST_TALL_BOX = preload("res://src/environment/burglar_base_world/tiles/TestTallBox.tscn")
#const LOCKED_DOOR = preload("res://src/environment/burglar_base_world/tiles/doors/locked_door/LockedDoor.tscn")

#const NOTE = preload("res://src/environment/burglar_base_world/tiles/note/Note.tscn")

const FLAG = preload("res://src/environment/burglar_base_world/tiles/safe/Safe.tscn")

func replace_tiles_with_instances():
	replace(TEST_TALL_BOX, 0)
	replace(TEST_DOOR, 1)
	replace(SECURITY_CAMERA, 11)
	replace(SHADOW, 12)
	replace(ENEMY_GUNNER, 9)
	replace(FLAG, 13)

func get_occupied_cells():
	var occupied_tiles = get_used_cells_by_id(0) + get_used_cells_by_id(1)
	return occupied_tiles

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
