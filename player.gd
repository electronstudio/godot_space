extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = 0.0

var Bullet = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation -= 2.0 * delta
	if Input.is_action_pressed("ui_right"):
		rotation += 2.0 * delta
	if Input.is_action_pressed("ui_up"):
		velocity += 500.0 * delta
	if Input.is_action_pressed("ui_down"):
		velocity -= 500.0 * delta
	if Input.is_action_pressed("ui_accept"):
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = velocity + 1000
		get_node("/root/main/bullets").add_child(bullet)
		$laser.show()
	else:
		$laser.hide()
		
	position += Vector2.UP.rotated(rotation) * velocity * delta
	var s = 2 + velocity/500
	$Camera2D.zoom = Vector2(s, s)


func _on_player_area_entered(area):
	print("player area", area)
