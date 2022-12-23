extends "res://src/entities/base_templates/base_entity/base_entity.gd"

onready var attack_range = $Areas/AttackRange

# Non-Player Variables
export var ITEM_DROP_PERCENT = 50
var current_bodies_in_attack_range = []

##SOUNDS:
onready var attack_sound = $SoundMachine/Attack


func _ready():
	attack_range.connect("body_entered", self, "_on_AttackRange_body_entered")
	attack_range.connect("body_exited", self, "_on_AttackRange_body_exited")	

func attack(target):
	pass
	
func search_for_target():
	pass

func hurt(attacker_area):
	.hurt(attacker_area)
	#Global.frame_freeze(0.5, 2)

func _on_AttackRange_body_entered(body):
	if body.health_manager.is_dead():
		return
	current_bodies_in_attack_range.append(body)


func _on_AttackRange_body_exited(body):
	current_bodies_in_attack_range.erase(body)


var hit_pos

func is_target_in_aim(target):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.hurtbox.collision_shape.shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(position,
				pos, [self], collision_mask)
		#print(result)
		if result:
			hit_pos.append(result.position)
			if !result.collider.get("entity_type"):
				break
			if result.collider.is_in_group("PLAYER"):
				return true
	return false

func aim(target):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.hurtbox.collision_shape.shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(global_position,
				pos, [self], collision_mask)
		#print(result)
		if result:
			hit_pos.append(result.position)
			if !result.collider.get("entity_type"):
				break
			if result.collider.is_in_group("PLAYER"):
				attack(target)
				break


