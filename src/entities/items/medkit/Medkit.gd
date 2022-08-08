extends "res://src/entities/items/base_templates/base_item/base_item.gd"


signal ammo_changed(new_ammo)

export var heal_value = 20

export var ammo = 1

onready var ammo_pack_amount = 1

onready var eat_sound = $Position2D/SoundMachine/Eat

func _ready():
	animation_machine.play_animation("Idle", "AnimationPlayer")

func add_ammo_pack() -> void:
	ammo = ammo + ammo_pack_amount
	emit_signal("ammo_changed", ammo)
	return

func is_out_of_ammo() -> bool:
	return ammo <= 0

func reduce_ammo() -> void:
	ammo = max(ammo - 1, 0)
	emit_signal("ammo_changed", ammo)

func action() -> void:
	if is_out_of_ammo():
		$Position2D/SoundMachine/Denied.play()
		return
	if weapon_owner.health_manager.health == weapon_owner.health_manager.max_health:
		return
	weapon_owner.health_manager.heal(heal_value)
	reduce_ammo()
	eat_sound.play()
	#sound_machine.play_sound("Shot")
