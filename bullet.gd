extends Area2D

var velocity 
onready var player = get_node("/root/main/player")

func _ready():
	$sound.play()
	position += Vector2.RIGHT.rotated(rotation) * 150

func init(parent, vel):
		position = parent.position
		rotation = parent.rotation
		velocity = vel
		parent.get_node("/root/main/bullets").add_child(self)
		
