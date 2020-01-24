extends Area2D

var velocity 
onready var player = get_node("/root/main/player")

func _ready():
	$sound.play()
	position += Vector2.RIGHT.rotated(rotation) * 150

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	if position.distance_to(player.position) > 5000:
		queue_free()

func _on_bullet_area_entered(area):
	queue_free()

func init(parent, vel):
		position = parent.position
		rotation = parent.rotation
		velocity = vel
		parent.get_node("/root/main/bullets").add_child(self)