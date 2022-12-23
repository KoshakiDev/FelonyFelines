extends "res://src/entities/base_templates/base_npc/base_npc.gd"

onready var handgun = $Visuals/Sprite/HandGun

var label: Label
onready var bullet_spawner = $Visuals/Sprite/HandGun/BulletSpawner

onready var vision_direction = $Visuals/VisionDirection

var target = null
onready var vision_area = $Visuals/VisionDirection/VisionArea

onready var search_directions = $SearchDirections

func _ready():
	if $Debug.has_node("Label"):
		label = $Debug/Label
	vision_area.connect("target_detected", self, "target_detected")
	vision_area.connect("target_lost", self, "target_lost")

	bullet_spawner.connect("shot_fired", self, "shot_fired")

func adjust_rotation(direction):
	vision_direction.look_at(vision_direction.global_position + direction)

func _physics_process(delta):
	adjust_rotation(movement.vector_to_movement_direction(movement.get_intended_velocity()))


func attack(target):
	var look_dir = (target.global_position - global_position).normalized()
	if look_dir.x < 0:
		visuals.scale.x = -1
	else:
		visuals.scale.x = 1
	
	if visuals.scale.x == -1:
		handgun.rotation = PI - (target.global_position - global_position).angle()
	elif visuals.scale.x == 1:
		handgun.rotation = (target.global_position - global_position).angle()
	bullet_spawner.set_shooting(true)

func shot_fired():
	attack_sound.play()
	
func search_for_target():
	return target

func target_detected(new_target):
	target = new_target

func target_lost():
	#print("target lost")
	target = null
