extends Node2D

export var entity_type = "ITEM"
export var item_type = "WEAPON"
export var entity_name = "NAME"

export var despawnable: bool = true
export var despawn_time: int = 5

export var in_inventory: bool = false

func setup_despawn():
	if despawnable:
		self.despawn_timer.wait_time = despawn_time
		self.despawn_timer.start()
		pass

func despawn():
	self.queue_free()
	pass

func is_despawned():
	return self.despawn_timer.is_stopped() and despawnable

func _process(delta):
	if is_despawned():
		despawn()
