extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.LEFT.rotated(rotation) * velocity * delta
	#$lasers.frame = ($lasers.frame + 1) % 16


func _on_bullet_area_entered(area):
	queue_free()
