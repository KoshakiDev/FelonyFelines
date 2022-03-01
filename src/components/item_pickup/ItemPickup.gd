extends Area2D


func _on_ItemPickup_area_entered(area):
	var item = area.owner
	if not item.is_in_group("ITEM"):
		return
	print(item)
	if item.item_type == "WEAPON":
		print(item.in_inventory)
		if item.in_inventory: return
		owner.weapon_manager.add_weapon(item)
	else:
		item._action(self)
