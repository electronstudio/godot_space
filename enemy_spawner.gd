extends Timer

export (PackedScene) var  Enemy
export var MAX_ENEMIES = 10

func _on_enemy_spawner_timeout():
	if get_child_count() < MAX_ENEMIES:
		var enemy = Enemy.instance()
		add_child(enemy)