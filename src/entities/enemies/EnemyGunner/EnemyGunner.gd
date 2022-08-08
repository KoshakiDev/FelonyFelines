extends "res://src/entities/base_templates/base_npc/base_npc.gd"

onready var handgun = $Visuals/Sprite/HandGun

var label: Label
onready var bullet_spawner = $Visuals/Sprite/HandGun/BulletSpawner

func _ready():
	if $Debug.has_node("Label"):
		label = $Debug/Label
	
	bullet_spawner.connect("shot_fired", self, "shot_fired")

func attack(target):
	var look_dir = (target.global_position - global_position).normalized()
	if look_dir.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	if sprite.scale.x == -1:
		handgun.rotation = PI - (target.global_position - global_position).angle()
	elif sprite.scale.x == 1:
		handgun.rotation = (target.global_position - global_position).angle()
	bullet_spawner.set_shooting(true)

func shot_fired():
	attack_sound.play()

func _on_Hurtbox_area_entered(area):
	if health_manager.is_dead(): return
	._on_Hurtbox_area_entered(area)
	var attacker = area.owner
	var attack_direction
	if area.is_in_group("PROJECTILE"):
		attacker = area
		attack_direction = attacker.dir
	else:
		var attacker_2 = attacker.owner
		attack_direction = attacker_2.intended_velocity
	
	if (attack_direction.x > 0 and sprite.scale.x == 1) or (attack_direction.x < 0 and sprite.scale.x == -1):
		state_machine.transition_to("Pain", {Back = true})
	elif (attack_direction.x > 0 and sprite.scale.x == -1) or (attack_direction.x < 0 and sprite.scale.x == 1):
		state_machine.transition_to("Pain", {Front = true})
	Global.frame_freeze(0.5, 2)
	


