extends "res://src/environment/burglar_base_world/tiles/doors/base_door/BaseDoor.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var interaction_zone = $InteractionZone

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_off_entrance()
	interaction_zone.connect("minigame_success", self, "minigame_success")
	

func turn_on_entrance():
	door_collider.disabled = true
	interact_back.monitoring = true
	interact_back.monitorable = true
	interact_front.monitoring = true
	interact_front.monitorable = true


func turn_off_entrance():
	door_collider.disabled = false
	interact_back.monitoring = false
	interact_back.monitorable = false
	interact_front.monitoring = false
	interact_front.monitorable = false

func minigame_success():
	interaction_zone.turn_off()
	turn_on_entrance()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
