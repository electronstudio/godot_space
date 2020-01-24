extends Area2D

var velocity = 1000.0
var TURNING = 0.7

var Bullet = preload("res://enemy_bullet.tscn")

onready var player = get_node("/root/main/player")


func _ready():
	position = player.position + Vector2.RIGHT.rotated(rand_range(0, PI*2)) * 5000
	rotation = player.position.angle_to_point(position) 

func _process(delta):


	var d = player.position.angle_to_point(position) 

	#if abs(Util.short_angle_dist(rotation, d))>0.4:
	rotation = Util.rotate_toward(rotation, d, TURNING*delta)
	#Util.lerp_angle(rotation, d, TURNING*delta)
		
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	
	if randf()<0.01:
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = 3000
		get_node("/root/main/bullets").add_child(bullet)
	
	

func _on_enemy_area_entered(area):
	$AnimationPlayer.play("fade")
	$CollisionPolygon2D.queue_free()
	$CPUParticles2D.emitting = true
	$CPUParticles2D.show()
	yield(get_tree().create_timer(1.0), "timeout")
	hide()
	queue_free()
	



