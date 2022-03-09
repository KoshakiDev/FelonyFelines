extends Node2D

export var entity_type = "ITEM"
export var item_type = "WEAPON"
export var entity_name = "NAME"

onready var item_pickup_area = $Position2D/PickUpRange
onready var despawn_timer = $Position2D/PickUpRange/DespawnTimer
onready var sprite = $Position2D/Visuals/Sprite
onready var animation_machine = $Position2D/AnimationMachine
onready var sound_machine = $Position2D/SoundMachine


export var despawnable: bool = true
export var despawn_time: int = 5
export var in_inventory: bool = false


func _ready():
	if !in_inventory:
		despawn_timer.connect("timeout", self, "_on_DespawnTimer_timeout")
		setup_despawn()
	else:
		item_pickup_area.queue_free()
	

func action(_subject):
	pass

func cancel_despawn():
	despawn_timer.stop()
	item_pickup_area.queue_free()

func setup_despawn():
	if despawnable:
		despawn_timer.wait_time = despawn_time
		despawn_timer.start()

func _on_DespawnTimer_timeout():
	queue_free()
