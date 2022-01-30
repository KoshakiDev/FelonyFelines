extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called when the node enters the scene tree for the first time.
func _ready():
	var image = Image.new()
	image.load("res://test folder/test collision from image/map_test.png")
	print("1")
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)

	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))

	for polygon in polygons:
		var collider = CollisionPolygon2D.new()
		collider.polygon = polygon
		add_child(collider)
