extends Timer

var Enemy = preload("res://enemy.tscn")

export var MAX_ENEMIES = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_enemy_spawner_timeout():
	if get_child_count() < MAX_ENEMIES:
		var enemy = Enemy.instance()
		add_child(enemy)