extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = 1600

var Bullet = preload("res://player_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(rad2deg(Vector2(0,0).angle_to_point(Vector2(-100,0))))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gamepad()
	if Input.is_action_pressed("ui_left"):
		rotation -= 2.0 * delta
	if Input.is_action_pressed("ui_right"):
		rotation += 2.0 * delta
	if Input.is_action_pressed("ui_up"):
		velocity += 700.0 * delta
	if Input.is_action_pressed("ui_down"):
		velocity -= 700.0 * delta
	if Input.is_action_just_pressed("ui_accept"):
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = velocity + 1000
		get_node("/root/main/bullets").add_child(bullet)
		#$laser.show()
	#else:
		#$laser.hide()
		
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	#var s = 2 + velocity/500
	#$Camera2D.zoom = Vector2(s, s)
	

func _on_player_area_entered(area):
	modulate = Color(1000, 1000, 1000, 255)
	yield(get_tree().create_timer(1.0), "timeout")
	modulate = Color(1, 1, 1, 255)
	print("player area", area)
	
func gamepad():
	var input = Vector2(Input.get_joy_axis(0, 0), Input.get_joy_axis(0, 1))
	var direction = input.angle()
	print(direction)
	if input.length() > 0.2:
		rotation = direction