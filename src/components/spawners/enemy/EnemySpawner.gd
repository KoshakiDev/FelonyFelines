extends Position2D

onready var spawn_area = $Area2D/CollisionShape2D.shape.extents

var enemyLoad = [preload("res://src/entities/enemies/EnemyGunner/EnemyGunner.tscn"),
			 preload("res://src/entities/enemies/EnemyScissors.tscn"),
			 preload("res://src/entities/enemies/EnemyPaper.tscn")]

#onready var enemies = $"../YSort"

var parent

func _ready():
	parent = get_parent().get_parent()

func random_pos():
	var offset = Vector2(rand_range(-spawn_area.x, spawn_area.x), rand_range(-spawn_area.y, spawn_area.y))
	return global_position + offset

func add_enemies(count):
	randomize()
	for i in range(count):
		var enemy = enemyLoad[randi() % enemyLoad.size()].instance()
		parent.add_child(enemy)
		
		enemy.set_as_toplevel(true)	
		enemy.global_position = random_pos()
