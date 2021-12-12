extends Position2D

onready var spawn_area = $Area2D/CollisionShape2D.shape.extents

var enemyLoad = [preload("res://src/entities/enemies/EnemyRock.tscn"),
			 preload("res://src/entities/enemies/EnemyScissors.tscn"),
			 preload("res://src/entities/enemies/EnemyPaper.tscn")]

export var enemy_count: int = 5

onready var enemies = $Enemies

func random_pos():
	var offset = Vector2(rand_range(-spawn_area.x, spawn_area.x), rand_range(-spawn_area.y, spawn_area.y))
	return global_position + offset

func add_enemies(count):
	randomize()
	for i in range(count):
		var enemy = enemyLoad[randi() % enemyLoad.size()].instance()
		enemies.add_child(enemy)
		
		enemy.set_as_toplevel(true)	
		enemy.global_position = random_pos()
