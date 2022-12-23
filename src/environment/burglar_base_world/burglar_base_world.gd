extends Node2D

onready var entity_world = $World/EntityWorld
onready var enemies = $World/EntityWorld/Enemies
onready var projectiles = $World/EntityWorld/Projectiles
onready var player = $World/EntityWorld/Player
onready var items = $World/EntityWorld/Items
onready var misc = $World/EntityWorld/Misc

onready var tile_objects = $World/TileObjects
onready var tile_floor = $World/TileFloor

func _ready():
	Global.set("main", self)
	Global.set("entity_world", entity_world)
	Global.set("items", items)
	Global.set("players", player)
	Global.set("projectiles", projectiles)
	Global.set("enemies", enemies)
	Global.set("misc", misc)
	tile_floor.delete_tiles(tile_objects)
	tile_objects.replace_tiles_with_instances()
	tile_floor.replace_tiles_with_instances()
	

func show_death_screen():
	SceneChanger.change_scene("res://src/menu/DeathScreen.tscn", "fade")

func back_to_menu():
	SceneChanger.change_scene("res://src/menu/Menu.tscn", "fade")
