extends Timer

export (PackedScene) var  Enemy
export var MAX_ENEMIES = 10
export var MAX_SCORE = 999999
export var MIN_SCORE = 0
onready var player = get_node("/root/main/player")

func _on_enemy_spawner_timeout():
	if get_child_count() < MAX_ENEMIES && player.score <= MAX_SCORE && player.score >= MIN_SCORE:
		var enemy = Enemy.instance()
		add_child(enemy)