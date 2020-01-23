extends Area2D

var velocity = 1000.0
var TURNING = 2 # max is about 2

var Bullet = preload("res://enemy_bullet.tscn")

onready var player = get_node("/root/main/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = rand_range(0, PI*2)
	position = player.position + Vector2.RIGHT.rotated(rotation) * 5000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Input.is_action_pressed("ui_left"):
#		rotation -= 2.0 * delta
#	if Input.is_action_pressed("ui_right"):
#		rotation += 2.0 * delta
#	if Input.is_action_pressed("ui_up"):
#		velocity += 500.0 * delta
#	if Input.is_action_pressed("ui_down"):
#		velocity -= 500.0 * delta
#	if Input.is_action_just_pressed("ui_accept"):
#		var bullet = Bullet.instance()
#		bullet.position = position
#		bullet.rotation = rotation
#		bullet.velocity = velocity + 1000
#		get_node("/root/main/bullets").add_child(bullet)

	var d = player.position.angle_to_point(position) 

	#if abs(Util.short_angle_dist(rotation, d))>0.4:
	rotation = Util.lerp_angle(rotation, d, TURNING*delta)
		
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	
	if randf()<0.01:
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = velocity + 2000
		get_node("/root/main/bullets").add_child(bullet)
	
	


func _on_enemy_area_entered(area):
	$AnimationPlayer.play("fade")
	$CPUParticles2D.emitting = true
	$CPUParticles2D.show()
	yield(get_tree().create_timer(1.0), "timeout")
	hide()
	queue_free()
	



