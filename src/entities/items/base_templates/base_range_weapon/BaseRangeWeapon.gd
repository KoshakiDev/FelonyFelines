extends "res://src/entities/items/base_templates/base_item/base_item.gd"

signal ammo_changed(new_ammo)

export var ammo = 10
export var recoil = 50


var weapon_owner: Node2D


onready var ammo_pack_amount = 5
onready var bullet_spawner = $Position2D/Visuals/Sprite/BulletSpawner

func _ready() -> void:
	bullet_spawner.connect("shot_fired", self, "shot_fired")
	print(bullet_spawner)

func init(weapon_owner: Node2D) -> void:
	self.weapon_owner = weapon_owner

#func action(_subject) -> void:
#	print(ammo)
#
#	reduce_ammo()
#
#	bullet_spawner.set_shooting(true)
#	animation_machine.play_animation("Shoot", "AnimationPlayer")
#	yield(animation_machine.get_node("AnimationPlayer"), "animation_finished")
	

#func bullet_spawner_set_shooting_true():
#	#print(bullet_spawner)
#	bullet_spawner.set_shooting(true)
#
#func bullet_spawner_set_shooting_false():
#	bullet_spawner.set_shooting(false)

func start_shooting() -> void:
	if is_out_of_ammo():
		return
	print(self.name)
	print(bullet_spawner)
	print(bullet_spawner.is_inside_tree())
	bullet_spawner.set_shooting(true)

func stop_shooting() -> void:
	bullet_spawner.set_shooting(false)

func add_ammo_pack() -> void:
	ammo = ammo + ammo_pack_amount
	emit_signal("ammo_changed", ammo)
	return

func is_out_of_ammo() -> bool:
	return ammo <= 0

func reduce_ammo() -> void:
	ammo = max(ammo - 1, 0)
	emit_signal("ammo_changed", ammo)

func shot_fired() -> void:
	animation_machine.play_animation("Shoot", "AnimationPlayer")
	weapon_owner.knockback += -1 * weapon_owner.movement_direction * recoil
	reduce_ammo()
	if is_out_of_ammo():
		stop_shooting()

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
