extends Position2D

onready var spawn_area = $Area2D/CollisionShape2D.shape.extents

var metkit_preload = preload("res://src/entities/objects/Medkit.tscn")

onready var medkits = $Medkits

func random_pos():
	var offset = Vector2(rand_range(-spawn_area.x, spawn_area.x), rand_range(-spawn_area.y, spawn_area.y))
	return global_position + offset

func add_medkit(count):
	randomize()
	for i in range(count):
		var metkit = metkit_preload.instance()
		medkits.add_child(metkit)
	
		metkit.global_position = random_pos()
