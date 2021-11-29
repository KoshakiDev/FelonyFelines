extends Node2D

enum WEAPON_SLOT {GOOD_HAND, CONTROL_SD, AXE}

var slots_unlocked = {
	WEAPON_SLOT.GOOD_HAND: true,
	WEAPON_SLOT.CONTROL_SD: true,
	WEAPON_SLOT.AXE: true,
}

onready var weapons = $HandPosition2D.get_children()

var cur_slot = 0
var cur_weapon = null

func _ready():
	switch_to_weapon_slot(cur_slot)
	pass

func switch_to_next_weapon():
	cur_slot = (cur_slot + 1) % slots_unlocked.size()
	print(cur_slot, "===> ", slots_unlocked)
	if !slots_unlocked[cur_slot]:
		switch_to_next_weapon()
	else:
		switch_to_weapon_slot(cur_slot)

func switch_to_prev_weapon():
	cur_slot = posmod((cur_slot - 1), slots_unlocked.size())
	if !slots_unlocked[cur_slot]:
		switch_to_next_weapon()
	else:
		switch_to_weapon_slot(cur_slot)

func switch_to_weapon_slot(slot_ind: int):
	if slot_ind < 0 or slot_ind >= slots_unlocked.size():
		return
	if !slots_unlocked[cur_slot]:
		return
	disable_all_weapons()
	cur_weapon = weapons[slot_ind]
	print(weapons[slot_ind])
	if cur_weapon.has_method("set_active"):
		cur_weapon.set_active()
	else:
		cur_weapon.visible = true
		print(cur_weapon.visible)


func disable_all_weapons():
	for weapon in weapons:
		if weapon.has_method("set_inactive"):
			weapon.set_inactive()
		else:
			weapon.visible = false
