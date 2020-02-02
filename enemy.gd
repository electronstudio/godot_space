extends Area2D

export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

var Bullet = preload("res://enemy_bullet.tscn")
onready var player = get_node("/root/main/player")

#func _ready():
#	position = player.position + Vector2.RIGHT.rotated(rand_range(0, PI*2)) * 5000
#	rotation = player.position.angle_to_point(position) 

func _process(delta):
	var d = player.position.angle_to_point(position) 
	rotation = Util.rotate_toward(rotation, d, TURNING*delta)
	position += Vector2.RIGHT.rotated(rotation) * VELOCITY * delta

	if position.distance_to(player.position) > 7000:
		queue_free()

	if randf()<FIRE_RATE:
		Bullet.instance().init(self, 3000)
#
#func _on_enemy_area_entered(area):
#	$explosion.play()
#	$AnimationPlayer.play("fade")
#	$CollisionPolygon2D.queue_free()
#	$CPUParticles2D.emitting = true
#	$CPUParticles2D.show()
#	player.score += 1
#	get_node("/root/main/HUD/score").text = str(player.score)
#	yield(get_tree().create_timer(1.0), "timeout")
#	queue_free()
	