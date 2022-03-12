extends "res://src/entities/items/base_templates/base_item/base_item.gd"

export var ammo = 10
export var recoil = 50
onready var ammo_pack_amount = 5
onready var bullet_spawner = $Position2D/Visuals/Sprite/BulletSpawner

func _ready():
	pass

func action(_subject):
	print(ammo)
	
	_subject.knockback += -1 * _subject.movement_direction * recoil
	reduce_ammo()
	
	animation_machine.play_animation("Shoot", "AnimationPlayer")
	yield(animation_machine.get_node("AnimationPlayer"), "animation_finished")
	

func bullet_spawner_set_shooting_true():
	#print(bullet_spawner)
	bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	bullet_spawner.set_shooting(false)


#nothing below here works

func add_ammo_pack():
	ammo = ammo + ammo_pack_amount
	return

func is_out_of_ammo():
	return ammo <= 0

func reduce_ammo():
	ammo = ammo - 1
	if is_out_of_ammo():
		queue_free()
		return

#func setup_max_ammo(shot_delay, animation_length, bullet_emitter_type):
#	var bullet_emitter_amount = 1
#	if bullet_emitter_type.get("amount"):
#		bullet_emitter_amount = bullet_emitter_type.amount
#	var a = shot_delay
#	var b = animation_length
#	var shots_fired = ceil(b/a)
#
#	return bullet_emitter_amount * shots_fired * max_ammo
#
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
#
