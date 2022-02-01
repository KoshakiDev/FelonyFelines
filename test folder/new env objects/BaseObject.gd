extends Node2D

export var entity_type = "WORLD"
export var entity_name = "NAME"


#these variables will be ADDED on top of the variables, 
# but not modify the variables

export var change_health = 0
export var change_velocity = Vector2.ZERO

export var change_attack_damage = 0

export var change_hurt_damage = 0
export var change_player_points = 0
export var change_item_drop_percent = 0

export var change_knockback = 0
export var change_knockback_on_action = 0

export var bullet_scene: PackedScene
export var change_shot_delay = 0.0
export var change_bullet_speed = 0
export var change_bullet_spread = 0
export var change_bullet_amount = 0

export var change_current_ammo = 0
export var change_max_ammo = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func apply_change(target):
	if target.get("entity_type"):
		if target.entity_type == "PLAYER":
			update_player(target, 1)
		elif target.entity_type == "ENEMY":
			update_enemy(target, 1)
	if target.get("velocity"):
		target.velocity += change_velocity

func update_health(target):
	target.health += change_health

func update_enemy(target, condition):
	update_health(target)
	target.ITEM_DROP_PERCENT += change_item_drop_percent * condition
	if target.entity_name == "GUNNER":
		update_bullet_spawner(target.bullet_spawner, condition)
	if target.entity_name == "BALL" or target.entity_name == "IMP":
		target.damage_value += change_attack_damage * condition
		target.knockback_value += change_knockback * condition
		
		
func update_player(target, condition=1):
	update_health(target)
	update_all_weapons(target, condition)
	


func update_all_weapons(target, condition):
	var weapons = target.weapon_manager.weapons
	for weapon in weapons:
		if weapon.get("bullet_spawner"):
			update_bullet_spawner(weapon.bullet_spawner, condition)

func update_bullet_spawner(bullet_spawner, condition):
	bullet_spawner.timer.wait_time += change_shot_delay * condition
	bullet_spawner.bullet_speed += change_bullet_speed * condition
	bullet_spawner.bullet_damage_value += change_attack_damage * condition
	bullet_spawner.bullet_knockback_value += change_knockback * condition
	
	if bullet_spawner.bullet_emitter.get("amount"):
		bullet_spawner.bullet_emitter.amount += change_bullet_amount * condition
		bullet_spawner.bullet_emitter.spread_angle += change_bullet_spread * condition
		


func remove_change(target):
	if target.get("entity_type"):
		if target.entity_type == "PLAYER":
			update_player(target, -1)
		elif target.entity_type == "ENEMY":
			update_enemy(target, -1)

func _on_Area_body_entered(body):
	var areaParent = body.owner
	print(body)
	print(areaParent)
	print('area entered')
	apply_change(body)

func _on_Area_body_exited(body):
	var areaParent = body.owner
	remove_change(body)
