extends "res:///src/entities/entityModules.gd"

export var speed = 250
export var damage_value:float = 10
export var knockback_value: float = 20

var direction

func _ready():
	$AnimationPlayer.play("Spin")

func _physics_process(delta):
	position += direction * speed * delta
	
	if find_targets_in_area(["wall"], $Area2D).size() > 0:
		queue_free()
		return

	var targets = find_targets_in_area(["player"], $Area2D)
	for target in targets:
		target.take_damage(self, damage_value, knockback_value)
		queue_free()
		break



func _on_Area2D_area_entered(area):
	if area.is_in_group('hitbox'):
		queue_free()
