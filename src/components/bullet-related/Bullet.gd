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
	$ShootSound.play()

func setup(dir, speed, damage_value, knockback_value) -> void:
	self.dir = dir
	self.speed = speed
	self.damage_value = damage_value
	self.knockback_value = knockback_value

func _physics_process(delta: float) -> void:
	if shooting:
		position += dir * speed * delta
		if start_pos.distance_to(global_position) > MAX_DISTANCE:
			queue_free()


func _on_Bullet_area_entered(area):
	var areaParent = area.owner
	print(area)
	
	if areaParent.entity_type == "WORLD": queue_free()
	
	if is_player_bullet:
		if areaParent.entity_type == "PLAYER": return
		elif areaParent.entity_type == "ITEM":
			if areaParent.entity_name == "SHIELD":
				return
	else:
		if areaParent.entity_type == "ENEMY": return
	
	queue_free()
	pass


func _on_Bullet_body_entered(body):
	#var bodyParent = body.owner
	#print(areaParent)
	print(body)
	if body.get_name() == "Walls" or body.get_name() == "Plants": queue_free()

