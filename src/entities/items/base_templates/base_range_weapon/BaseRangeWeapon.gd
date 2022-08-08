extends "res://src/entities/items/base_templates/base_item/base_item.gd"

signal ammo_changed(new_ammo)

export var ammo = 10
export var recoil = 50

export var ammo_pack_amount = 5
onready var bullet_spawner = $Position2D/Visuals/Sprite/BulletSpawner

func _ready() -> void:
	item_drop_sound.play()
	bullet_spawner.connect("shot_fired", self, "shot_fired")
	#print(bullet_spawner)

func set_inactive():
	.set_inactive()
	stop_shooting()

func action():
	start_shooting()

func start_shooting() -> void:
	if is_out_of_ammo():
		return
	#print(self.name)
	#print(bullet_spawner)
	#print(bullet_spawner.is_inside_tree())
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
	sound_machine.play_sound("Shot")
	Shake.shake(2.5, .5)
	
