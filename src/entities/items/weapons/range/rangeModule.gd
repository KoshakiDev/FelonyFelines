extends "res://src/entities/items/itemModules.gd"

export var max_ammo = 10
onready var ammo = max_ammo

func _ready():
	pass 

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
	print("ammo fired: ", bullet_emitter_amount * ceil(shots_fired))
	#print(shot_delay)
	#print(animation_length)
	#print(bullet_emitter_amount)
	#print(ceil(shots_fired), " ", shots_fired)

func action(_subject):
	if ammo <= 0:
		print("no ammo")
		return
	deplete_ammo()
	self.animation_player.play("Shoot")
	print("ammo left: ", ammo)

func bullet_spawner_set_shooting_true():
	self.bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	self.bullet_spawner.set_shooting(false)

func setup_max_ammo(shot_delay, animation_length, bullet_emitter_type):
	var bullet_emitter_amount = 1
	if bullet_emitter_type.get("amount"):
		bullet_emitter_amount = bullet_emitter_type.amount
	var a = shot_delay
	var b = animation_length
	var shots_fired = ceil(b/a)
	
	return bullet_emitter_amount * shots_fired * max_ammo
