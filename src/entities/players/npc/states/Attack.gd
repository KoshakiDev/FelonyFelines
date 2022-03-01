extends State

#NPC ATTACK STATE

var melee_weapons = ["FISTS", "AXE", "SPEAR", "SHIELD"]
var long_range_weapons = ["REVOLVER", "SHOTGUN", "ASSAULTRIFLE", "MINIGUN"]


func chooseLongRange():
	while not owner.weapon_manager.cur_weapon.entity_name in long_range_weapons:
		owner.switch_to_next_weapon()

func chooseMelee():
	while not owner.weapon_manager.cur_weapon.entity_name in melee_weapons:
		owner.switch_to_next_weapon()

func enter(msg := {}) -> void:
	if owner.movement_player.current_animation == "Decel_1" or owner.movement_player.current_animation == "Decel_2":
		yield(owner.movement_player, "animation_finished")
	owner.play_animation("Idle", "Movement")
	print("transitioned to attack")
	
func exit() -> void:
	pass

func point_gun():
	var target_pos = Global.get_closest_enemy(owner.global_position)
	print("Shooting at ", target_pos)
	owner.adjust_hand_rotation(target_pos)

func physics_update(_delta: float) -> void:
	if !owner.there_is_an_enemy_in_distance(64 * 100):
		state_machine.transition_to("Move", {Accel = true})
	chooseLongRange()
	point_gun()
	owner.action()
