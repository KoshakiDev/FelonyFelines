extends "res://src/entities/items/base_templates/base_item/base_item.gd"

export var max_ammo = 10
export var recoil = 50
onready var ammo = max_ammo
onready var bullet_spawner = $Position2D/Visuals/Sprite/BulletSpawner

func _ready():
	pass

func action(_subject):
	_subject.knockback += -1 * _subject.movement_direction * recoil
	animation_machine.play_animation("Shoot", "AnimationPlayer")
	yield(animation_machine.get_node("AnimationPlayer"), "animation_finished")


func bullet_spawner_set_shooting_true():
	#print(bullet_spawner)
	bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	bullet_spawner.set_shooting(false)


#nothing below here works

func setup_max_ammo(shot_delay, animation_length, bullet_emitter_type):
	var bullet_emitter_amount = 1
	if bullet_emitter_type.get("amount"):
		bullet_emitter_amount = bullet_emitter_type.amount
	var a = shot_delay
	var b = animation_length
	var shots_fired = ceil(b/a)
	
	return bullet_emitter_amount * shots_fired * max_ammo


<<<<<<< HEAD:src/entities/items/weapons/range/rangeModule.gd


#func deplete_ammo():
#	var shot_delay = self.bullet_spawner.shot_delay
#	var animation_length = self.animation_player.get_animation("Shoot").length
#	var bullet_emitter_type = self.bullet_spawner.bullet_emitter
#	var bullet_emitter_amount = 1
#	if bullet_emitter_type.get("amount"):
#		bullet_emitter_amount = bullet_emitter_type.amount
#	var a = shot_delay
#	var b = animation_length
#	var shots_fired = b/a
#	#ceil isnt working correctly for 0.1 / 0.1; it returns 2
#
#	print(ceil(b/a), " ", bullet_emitter_amount)
#	ammo -= bullet_emitter_amount * ceil(shots_fired)
#	#print("ammo fired: ", bullet_emitter_amount * ceil(shots_fired))
#	#print(shot_delay)
#	#print(animation_length)
#	#print(bullet_emitter_amount)
#	#print(ceil(shots_fired), " ", shots_fired)

func action(_subject):
	if ammo <= 0:
		print("no ammo")
		return
	#deplete_ammo()
	_subject.knockback += -1 * _subject.movement_direction * knockback_value_on_action
	self.animation_player.play("Shoot")
	yield(self.animation_player, "animation_finished")
	#print("ammo left: ", ammo)

func bullet_spawner_set_shooting_true():
	self.bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	self.bullet_spawner.set_shooting(false)

#func setup_max_ammo(shot_delay, animation_length, bullet_emitter_type):
#	var bullet_emitter_amount = 1
#	if bullet_emitter_type.get("amount"):
#		bullet_emitter_amount = bullet_emitter_type.amount
#	var a = shot_delay
#	var b = animation_length
#	var shots_fired = ceil(b/a)
#
#	return bullet_emitter_amount * shots_fired * max_ammo
=======
func deplete_ammo():
	var shot_delay = self.bullet_spawner.shot_delay
	var animation_length = self.animation_player.get_animation("Shoot").length
	var bullet_emitter_type = self.bullet_spawner.bullet_emitter
	var bullet_emitter_amount = 1
	if bullet_emitter_type.get("amount"):
		bullet_emitter_amount = bullet_emitter_type.amount
	var a = shot_delay
	var b = animation_length
	var shots_fired = b/a
	#ceil isnt working correctly for 0.1 / 0.1; it returns 2
	
	print(ceil(b/a), " ", bullet_emitter_amount)
	ammo -= bullet_emitter_amount * ceil(shots_fired)
	#print("ammo fired: ", bullet_emitter_amount * ceil(shots_fired))
	#print(shot_delay)
	#print(animation_length)
	#print(bullet_emitter_amount)
	#print(ceil(shots_fired), " ", shots_fired)
>>>>>>> c79381f21b5fa2c48fad5615dd64ac7c5f6f0ff8:src/entities/items/base_templates/base_range_weapon/BaseRangeWeapon.gd
