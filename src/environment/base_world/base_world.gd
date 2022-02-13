extends Node2D

onready var info_text = $InfoPos/Info



onready var timer = $WaveTimer


onready var entity_world = $World/EntityWorld

onready var enemies = $World/EntityWorld/Enemies
onready var projectiles = $World/EntityWorld/Projectiles
onready var players = $World/EntityWorld/Players
onready var items = $World/EntityWorld/Items
onready var spawners = $World/EntityWorld/Spawners.get_children()
onready var misc = $World/EntityWorld/Misc

onready var navigation = $World/Navigation2D

var wave_num = 0
var points = 0
var is_wave_updating = false

var enemy_count = 0

signal all_dead

func _ready():
	Ngio.request("Event.logEvent", {"event_name": "NewRoundLoaded","host": "https://newgrounds.com/"})
	
	#Ngio.request("App.logView", {"host": "https://newgrounds.com/"})
	AudioServer.set_bus_volume_db(0, 0)
	$InfoAnimationPlayer.play("Idle")
	update_board()
	Global.set("main", self)
	Global.set("entity_world", entity_world)
	Global.set("items", items)
	Global.set("players", players)
	Global.set("projectiles", projectiles)
	Global.set("enemies", enemies)
	Global.set("misc", misc)
	Global.set("navigation", navigation)
	update_wave()
	
func update_board():
	info_text.bbcode_text = "[center]WAVE: " + str(wave_num) + "[/center]\n[center]POINTS: " + str(points) + "[/center]\n[center]LEFT: " + str(enemy_count) + "[/center]"

func update_points(point_amount):
	points += point_amount
	update_board()

func update_wave():
	is_wave_updating = true
	wave_num += 1
	
	for spawner in spawners:
		enemy_count += wave_num
		spawner.add_enemies(wave_num)

	update_board()
	#timer.start()
	#yield(timer, "timeout")
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
	Ngio.request("ScoreBoard.postScore", {"id": 11467, "value": points})
	Ngio.request("ScoreBoard.postScore", {"id": 11468, "value": wave_num})
	back_to_menu()

func show_death_screen():
	SceneChanger.change_scene("res://src/menu/DeathScreen.tscn", "fade")

func back_to_menu():
	SceneChanger.change_scene("res://src/menu/Menu.tscn", "fade")


func _on_Main_all_dead():
	all_players_dead()


func _on_Timer_timeout():
	print("sent signal")
	get_tree().call_group("enemy", 'get_target_path', Global.brother_1.global_position)
