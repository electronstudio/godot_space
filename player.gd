extends Area2D

export var velocity = 1600
export var turning = 4.0
export var health = 10

var Bullet = preload("res://player_bullet.tscn")

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation -= turning * delta
	if Input.is_action_pressed("ui_right"):
		rotation += turning * delta
	if Input.is_action_just_pressed("ui_accept"):
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.rotation = rotation
		get_node("/root/main/bullets").add_child(bullet)

	gamepad(delta)
	laser(delta)

	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	
	
func _on_player_area_entered(area):
	health -= 1
	get_node("../HUD/health").value = health
	if health <= 0:
		get_tree().reload_current_scene()
	hitFX()
	
	
	
	
	
	
func hitFX():
	modulate = Color(1000, 0, 0, 255)
	yield(get_tree().create_timer(1.0), "timeout")
	modulate = Color(1, 1, 1, 255)
	
	

	
func gamepad(delta):
	var input = Vector2(Input.get_joy_axis(0, 0), Input.get_joy_axis(0, 1)) + virtual_stick_direction
	if input.length() > 0.2:
		var direction = input.angle()
		rotation = Util.rotate_toward(rotation, direction, turning * delta) 
		

var charge = 0.0

enum  {CHARGING, DISCHARGING}
var laser = DISCHARGING

func laser(delta):
	if Input.is_action_just_pressed("ui_accept"):
		laser = CHARGING

	if Input.is_action_just_released("ui_accept"):
		laser = DISCHARGING
	
	if laser == CHARGING:
		charge += delta

	
	if laser == DISCHARGING:
		charge -= delta
		if charge > 0.1:
			$laser.show()
			$laser.monitorable = true
		else:
			$laser.hide()
			$laser.monitorable = false
	
	charge = clamp(charge, 0.0, 3.0)
	get_node("../HUD/charge").value = charge
	
	
var virtual_stick_origin = Vector2.ZERO
var virtual_stick_direction = Vector2.ZERO

func _input(event):
	if event is InputEventScreenTouch:
		if event.position.x < get_viewport().size.x/2.0:
			if event.pressed:
				virtual_stick_origin = event.position
				print("pressed")
		else:
			if event.pressed:
				Input.action_press("ui_accept")
			else:
				Input.action_release("ui_accept")
	elif event is InputEventScreenDrag and event.position.x < get_viewport().size.x/2.0:
		#print(virtual_stick_origin, )
		virtual_stick_direction =  (event.position - virtual_stick_origin).normalized()
#		print(virtual_stick_direction)
#		if virtual_stick_direction.length() > 2:
#			rotation = Util.rotate_toward(rotation, virtual_stick_direction.angle(), turning * get_process_delta_time()) 
	
	
	
	
	