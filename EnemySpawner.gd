extends Position2D

onready var spawn_area = $Area2D/CollisionShape2D.shape.extents
onready var spawn_origin = $Area2D/CollisionShape2D.global_position - spawn_area

var enemyLoad = [preload("res://src/entities/enemies/EnemyRock.tscn"),
			 preload("res://src/entities/enemies/EnemyScissors.tscn"),
			 preload("res://src/entities/enemies/EnemyPaper.tscn")]

var new_wave: bool = false
export var enemy_count: int = 5

onready var enemies = $Enemies

func random_pos():
	var offset = Vector2(rand_range(spawn_origin.x, spawn_area.x), rand_range(spawn_origin.y, spawn_area.y))
	return global_position + offset

func add_enemies(count):
	randomize()
	for i in range(count):
		var enemy = enemyLoad[randi() % enemyLoad.size()].instance()
		enemies.add_child(enemy)
		
		enemy.set_as_toplevel(true)	
		enemy.global_position = random_pos()
	pass
	
func _process(delta):
	if new_wave:
		Global.main.update_wave()
		add_enemies(enemy_count)
	new_wave = (enemies.get_child_count() == 0)
