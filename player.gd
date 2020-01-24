extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocity = 1600
export var turning = 4.0
export var health = 10


var Bullet = preload("res://player_bullet.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	var input = Vector2(Input.get_joy_axis(0, 0), Input.get_joy_axis(0, 1))
	if input.length() > 0.2:
		var direction = input.angle()
		#rotation = Util.lerp_angle(rotation, direction, 4*get_process_delta_time() )
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