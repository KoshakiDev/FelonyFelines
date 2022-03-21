extends Node2D

export var level = "res://src/environment/LaunchScene.tscn"

func _ready():
	$CanvasLayer/Sprite.visible = true
	$AnimationPlayer.play("idle")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			SceneChanger.change_scene(level, "fade")
			$CanvasLayer/Sprite.visible = false
