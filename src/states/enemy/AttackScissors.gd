extends State

export var dash_time_ms: int = 50
export var max_dash_speed: int = 200
var dashing: bool = false
var targetGroups
var direction
var timer = 0

func enter(msg := {}) -> void:
	start_dash()

func start_dash():
	owner.play_animation("DashStart")
	yield(owner.anim_player, "animation_finished")
	
	# start dash loop
	owner.loop_animation("DashLoop")
	timer = 0
	dashing = true
	
	if owner.controlled:
		targetGroups = ["enemy"]
	else:
		targetGroups = ["player1", "player2"]

	var targets = owner.find_targets_in_area(targetGroups, owner.hit_range)
	
	if targets.size() == 0:
		end_dash()
		return
		
	var target = targets[0]
	
	direction = (target.position - owner.position).normalized() * max_dash_speed
	
func continue_dash():
	owner.velocity = owner.move_and_slide(direction)
	deal_damage(targetGroups)
	
func deal_damage(targetGroups):
	var targets = owner.find_targets_in_area(targetGroups, owner.hit_range2)
	for target in targets:
		target.health = target.health_bar.take_damage(target.health, target.max_health, owner.damage_value)

func end_dash():
	dashing = false
	
	owner.play_animation("DashEnd")
	yield(owner.anim_player, "animation_finished")

	state_machine.transition_to("Chase")


func physics_update(delta: float) -> void:
	if timer == dash_time_ms: 
		end_dash()
		return
		
	if dashing:
		continue_dash()
		timer = timer + 1

	pass
