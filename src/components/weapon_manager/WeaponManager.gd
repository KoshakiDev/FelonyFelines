extends Node2D

onready var weapons_container = self

onready var weapons = weapons_container.get_children()

var max_slot_size = 5
var weapon_slots_size = 1
var cur_slot = 0
var cur_weapon = null

var weapon_owner: Node2D

func _ready():
	if weapons.size() != 0:
		switch_to_weapon_slot(cur_slot)

func init(weapon_owner: Node2D) -> void:
	self.weapon_owner = weapon_owner
	for weapon in weapons:
		weapon.init(weapon_owner)

func return_ammo_count():
	if cur_weapon == null:
		return -1
	if cur_weapon.get("ammo") != null:
		return cur_weapon.ammo
	else:
		return -1

func add_weapon(new_weapon):
	new_weapon.cancel_despawn()
	if is_duplicant(new_weapon):
		# TODO: increase amount of click allowed
		var dupe_weapon = get_duplicant(new_weapon)
		if dupe_weapon.item_type == "RANGE" or dupe_weapon.item_type == "MEDKIT":
			dupe_weapon.add_ammo_pack()
			owner.ammo_bar.update_ammo_bar(return_ammo_count())
	if is_duplicant(new_weapon):
		#print("is duplicant")
		new_weapon.queue_free()
		return
	
	new_weapon.in_inventory = true
	new_weapon.despawnable = false
	new_weapon.position = Vector2.ZERO
	if new_weapon.has_method("init"):
		new_weapon.init(weapon_owner)
	Global.reparent(new_weapon, weapons_container)
	yield(new_weapon, "tree_entered")
	update_children()

func get_duplicant(new_weapon):
	for weapon in weapons:
		if new_weapon.entity_name == weapon.entity_name:
			return weapon
	return null
func is_duplicant(new_weapon):
	var dupe_weapon = get_duplicant(new_weapon)
	return dupe_weapon != null


func switch_to_next_weapon():
	update_children()
	if weapon_slots_size == 0:
		return
	
	cur_slot = (cur_slot + 1) % weapon_slots_size
	switch_to_weapon_slot(cur_slot)
	if return_ammo_count() <= 0 and cur_weapon.item_type != "MELEE":
		switch_to_next_weapon()

func switch_to_prev_weapon():
	update_children()
	
	if weapon_slots_size == 0:
		return
	
	cur_slot = posmod((cur_slot - 1), weapon_slots_size)
	switch_to_weapon_slot(cur_slot)
	if return_ammo_count() <= 0 and cur_weapon.item_type != "MELEE":
		switch_to_prev_weapon()

func switch_to_weapon_slot(slot_ind: int):
	if slot_ind < 0 or slot_ind >= weapon_slots_size:
		return
	disable_all_weapons()
	cur_weapon = weapons[slot_ind]
	if cur_weapon.has_method("set_active"):
		cur_weapon.set_active()
	else:
		cur_weapon.visible = true
	

func disable_all_weapons():
	for weapon in weapons:
		if weapon.has_method("set_inactive"):
			weapon.set_inactive()
		else:
			weapon.visible = false

func update_children():
	weapons = weapons_container.get_children()
	weapon_slots_size = weapons.size()
	cur_weapon = null

	switch_to_weapon_slot(cur_slot)
