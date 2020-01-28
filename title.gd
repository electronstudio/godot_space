extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/lastscore.text = str(Global.last_score)
	$HUD/highscore.text = str(Global.high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$player.position.x += delta*1000
	$player.rotation += delta
	if Input.is_action_just_pressed("fire"):
		get_tree().change_scene("res://main.tscn")
