extends State

const points_effect_packed := preload("res://src/ScreenEffects/PointEffect.tscn")

func enter(msg := {}) -> void:
	owner.hurtbox_shape.disabled = true
	owner.death_sound.play()
	owner.play_animation("Death", "Animations")
	update_points()
	pass
	

func enemy_drop():
	# drop is a number between 0 and 99
	var drop = randi() % 100

	# if drop is strictly less than our percentage, then drop something
	if drop < owner.ITEM_DROP_PERCENT:
		var drop_list = []
		for key in Global.ITEM_DROP_WEIGHTS:
			for _i in range(Global.ITEM_DROP_WEIGHTS[key]):
				drop_list.append(key)

		# index is a number between 0 and list size - 1
		var index = randi() % drop_list.size()
		# load the scene at index
		var scene = str("res://src/entities/items/", drop_list[index], ".tscn")
		
		#print(scene)
		
		instance_scene(load(scene).instance())

func instance_scene(instance):
	instance.global_position = owner.global_position
	Global.items.add_child(instance)

func update_points() -> void:
	var points = 100
	var points_effect := points_effect_packed.instance()
	points_effect.init(points)
	Global.misc.add_child(points_effect)
	points_effect.global_position = owner.global_position
	Global.main.update_points(points)

func delete_enemy():
	enemy_drop()
	#print("1")
	if Global.main == null or Global.UI_layer == null:
		owner.queue_free()
		return
	Global.enemy_count = Global.enemy_count - 1
	if Global.enemy_count == 0:
		Global.main.update_wave()
	
	#Global.main.update_board()
	Global.UI_layer.update_board()
	owner.queue_free()
