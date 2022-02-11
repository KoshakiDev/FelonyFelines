extends Node2D

export var level = "res://src/environment/LaunchScene.tscn"

func _ready():
	$AnimationPlayer.play("idle")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			SceneChanger.change_scene(level, "fade")
