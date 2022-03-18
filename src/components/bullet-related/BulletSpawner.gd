tool
class_name BulletSpawner
extends Position2D

# Called whenever a shot is ready and shooting is false
signal shot_ready()
signal shot_fired()

# Scene to use as a bullet, it's script needs to extend Bullet
export var bullet_scene: PackedScene
# time between shots
export var shot_delay: float = .1
# speed of the emitted bullets
export var bullet_speed: float = 400

export var bullet_damage_value = 5
export var knockback_value = 20
export var shoot_anim_player_p: NodePath

# the emitter to be used for spawning bullets (controls behaviour)
var bullet_emitter: BulletEmitter

# offset to the rotation, added to BulletSpawners rotation
var rotation_offset: float = 0.0

var can_shoot: bool = false

var shoot_anim_player: AnimationPlayer

var timer: Timer


func _ready() -> void:
	if Engine.editor_hint:
		return
	if shoot_anim_player_p != "":
		shoot_anim_player = get_node(shoot_anim_player_p)
		if not shoot_anim_player.has_animation("Shoot"):
			printerr("Weapon %s does not have a valid Shoot animation in %s"
				% [owner.name, shoot_anim_player_p])
			return
		var anim_length := shoot_anim_player.get_animation("Shoot").length / shoot_anim_player.playback_speed
		if shot_delay < anim_length:
			# TODO: Don't use the shot delay on a timer, use the animation ending
			# signal instead.
			# Adjust the shot delay if it does not fit in the animation with a small buffer
			shot_delay = anim_length + .0001
			printerr("The shot delay in %s is to short for the animation length. It was adujusted from %s to %s"
				% [owner.name, shot_delay, anim_length])
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = shot_delay
	timer.one_shot = false
	timer.autostart = false
	timer.connect("timeout", self, "_shoot")
	if bullet_emitter:
		bullet_emitter.setup(self, bullet_scene)
	else:
		printerr("emitter in BulletSpawner is not a BulletEmitter!")
		queue_free()

#func shoot():
##	if timer.is_stopped():
##		return
#	var shoot_dir = Vector2.RIGHT.rotated(global_rotation + rotation_offset).normalized()
#	bullet_emitter.shoot(global_position, shoot_dir, bullet_speed, bullet_damage_value, knockback_value)
#
##	timer.start()

func set_shooting(val: bool) -> void:
	if val:
		can_shoot = true
		if timer.is_stopped():
			_shoot()
			timer.start()
	else:
		can_shoot = false
		

func _shoot() -> void:
	if not can_shoot:
		
		#print("no shooting")
		timer.stop()
		emit_signal("shot_ready")
		return
	#print("shooting")
	var shoot_dir = Vector2.RIGHT.rotated(global_rotation + rotation_offset).normalized()

	bullet_emitter.shoot(global_position, shoot_dir, bullet_speed, bullet_damage_value, knockback_value)
	emit_signal("shot_fired")

# Workaround for resource list
func _get_property_list() -> Array:
	var exported_resource_property: Dictionary = {
		"name":"bullet_emitter",
		"type":TYPE_OBJECT,
		"hint":PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "BulletEmitter",
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		}
	return [exported_resource_property]
