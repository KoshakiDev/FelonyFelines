class_name Bullet
extends Node2D

const MAX_DISTANCE := 2000

# Internal state
var dir: Vector2 = Vector2.RIGHT
var speed: float = 1.0
var shooting: bool = false
export var is_player_bullet:bool = true

onready var start_pos := global_position

var is_projectile = true

var damage_value = 5
var knockback_value = 20


func _ready() -> void:
	shooting = true

func setup(dir, speed, damage_value, knockback_value) -> void:
	#print(dir)
	self.dir = dir
	self.speed = speed
	self.damage_value = damage_value
	self.knockback_value = knockback_value
	rotation = (dir - Vector2.ZERO).angle()
	
	
func _physics_process(delta: float) -> void:
	if shooting:
		position += dir * speed * delta
		if start_pos.distance_to(global_position) > MAX_DISTANCE:
			queue_free()
		if current_body != null:
			var tile_pos = current_body.world_to_map(position)
			var tile_in_front = current_body.get_cellv(tile_pos + Vector2(0, 1))
			if tile_in_front == 0:
				queue_free()

func _on_Bullet_area_entered(area):
	var areaParent = area.owner
	#print(area)
	if is_player_bullet:
		if areaParent.entity_type == "PLAYER": return
		elif areaParent.entity_type == "ITEM":
			return
	else:
		if areaParent.entity_type == "ENEMY": return
	
	queue_free()
	pass

var current_body

func _on_Bullet_body_entered(body):
	if body.get_name() == "Walls" or body.get_name() == "Plants": 
		current_body = body

func _on_Bullet_body_exited(body):
	current_body = null
