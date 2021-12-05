extends Position2D

var enemyLoad = [preload("res://src/entities/enemies/EnemyRock.tscn"),
			 preload("res://src/entities/enemies/EnemyScissors.tscn"),
			 preload("res://src/entities/enemies/EnemyPaper.tscn")]

var new_wave: bool = false
export var enemy_count: int = 5
export var spawn_radius: int = 250

onready var enemies = $Enemies

var wave: int = 0

func random_pos(radius):
	randomize()
	var offset = Vector2(rand_range(-radius, radius), rand_range(-radius, radius))

	return global_position + offset

func add_enemies(count):
	randomize()
	for i in range(count):
		var enemy = enemyLoad[randi() % enemyLoad.size()].instance()
		enemies.add_child(enemy)
		
		enemy.set_as_toplevel(true)	
		enemy.global_position = random_pos(spawn_radius)
	pass
	

func _ready():
	print(position)
	pass # Replace with function body.

func _process(delta):
	if new_wave:
		wave = wave + 1
		add_enemies(enemy_count)
		
	new_wave = (enemies.get_child_count() == 0)
	$Label.text = "Enemy Spawner: {count}".format({"count": enemies.get_child_count()})
	pass
