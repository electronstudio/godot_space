extends Area2D

var velocity = 4000

func _ready():
	position += Vector2.RIGHT.rotated(rotation) * 150

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta

func _on_bullet_area_entered(area):
	queue_free()
