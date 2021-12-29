extends Node2D

onready var camera = $Camera2D
onready var info_text = $InfoPos/Info
onready var spawners = $Arena/YSort/Spawners.get_children()

onready var timer = $Timer

var wave_num = 0
var points = 0
var currently_controlled = "none"
var is_wave_updating = false

var enemy_count = 0

signal all_dead

func _ready():
	$InfoAnimationPlayer.play("Idle")
	update_board()
	Global.set("main", self)
	update_wave()
	
func update_board():
	info_text.bbcode_text = "[center]WAVE: " + str(wave_num) + "[/center]\n[center]POINTS: " + str(points) + "[/center]\n[center]LEFT: " + str(enemy_count) + "[/center]"

func update_points(point_amount):
	points += point_amount
	
	if points % 500 == 0:
		$Arena/YSort/medkitSpawner.add_medkit(1)
	
	update_board()

func update_wave():
	is_wave_updating = true
	wave_num += 1
	
	for spawner in spawners:
		enemy_count += wave_num
		spawner.add_enemies(wave_num)

	update_board()
	timer.start()
	yield(timer, "timeout")
	is_wave_updating = false

func _process(delta):
	if Global.brother_1.health <= 0 and Global.brother_2.health <= 0:
		Global.brother_1.set_process(false)
		Global.brother_1.set_process(false)
		emit_signal("all_dead")
		set_process(false)

func all_players_dead():
	$Dead.play()
	yield($Dead, "finished")
	#show_death_screen()
	Global.final_score = points
	Global.wave_survived = wave_num
	back_to_menu()

func show_death_screen():
	SceneChanger.change_scene("res://src/menu/DeathScreen.tscn", "fade")

func back_to_menu():
	SceneChanger.change_scene("res://src/menu/Menu.tscn", "fade")


func _on_Main_all_dead():
	all_players_dead()
