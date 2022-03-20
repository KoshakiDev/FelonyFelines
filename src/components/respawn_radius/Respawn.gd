extends Area2D

onready var respawn_timer = $RespawnTimer
onready var anim_player = $AnimationPlayer
onready var progress_sprite := $SpriteContainer/ProgressSprite

export var respawn_time = 2.5


func _ready():
	deactivate_respawn_radius()
	setup_timer()
	progress_sprite.material = progress_sprite.material.duplicate()

func _process(delta: float) -> void:
	progress_sprite.material.set_shader_param("progress", 1.0 - respawn_timer.time_left / respawn_time)

func activate_respawn_radius():
	monitoring = true
	visible = true
	anim_player.play("Not Healing")
	progress_sprite.material.set_shader_param("progress", 0)
	setup_timer()

func deactivate_respawn_radius():
	monitoring = false
	visible = false

func setup_timer():
	respawn_timer.wait_time = respawn_time
	respawn_timer.one_shot = true
	respawn_timer.autostart = false
	
func _on_RespawnTimer_timeout():
	deactivate_respawn_radius()
	owner.respawn_player()

func _on_Respawn_body_entered(body):
	if owner == body:
		return
	if not body.is_in_group("PLAYER"):
		return
	if body.health_manager.is_dead():
		return
	respawn_timer.start()
	anim_player.play("Healing")
	
func _on_Respawn_body_exited(body):
	if owner == body:
		return
	if not body.is_in_group("PLAYER"):
		return
	if body.health_manager.is_dead():
		return
	respawn_timer.stop()
	anim_player.play("Not Healing")
