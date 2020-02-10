# Space Shooter Tutorial

Download the [starter project](godot_space1.zip).  Import it into Godot.  Run the game.  You should have a spaceship sprite that can turn left and right.
There is also lighting and a HUD.

## 1. Velocity 

Change the `velocity` of the `player` to 1600 in the node inspector.  Run the game.

## 2. Camera

We need a camera to track the player.  Add a `Camera2D` node to the `player` node.  In the node inspector set:
* Current: On
* Zoom x: 6
* Zoom y: 6
* Drag Margin:
    * Left: 0
    * Right: 0
    * Top: 0
    * Bottom: 0
        
## 3. Background
   
We would like to add another layer to the scrolling background.
1. Add another `ParallaxLayer` node to the `ParallaxBackground` node.
2. Click on the `ParallaxLayer2`.
3. In the node inspector, set:
    * Motion: Mirroring x: 15360
    * Motion: Mirroring y: 15360
3. Find `backgrounds/stars_big_1024.png` in the filesystem (Bottom left of screen).
4. Drag into the scene in the centre of the screen.
5. Click on the `stars_big_1024` sprite node.
6. In the node inspector, under `Node2D` `Transform` set:
    * Position x: 7680
    * Position y: 7680
    * Scale x: 15
    * Scale y: 15

Run the game to verify it works.

## 4. Particle effect

The player already has a `CPUParticles2D` node made for you.  Click on it.  In node inspector:
* Emitting: On
* Amount: 50

Experiment with changing these settings.  What do they do?
* Lifetime
* Spread
* Gravity
* Velocity
* Color
* Anything else you like


## 5. Make enemy move

Open the `enemy.tscn` scene file by double clicking it.

Right click on the `enemy` node and attach a script.  Replace the contents of the script with:

```gdscript
extends Area2D

export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

var Bullet = preloadcopypaste("res://enemy_bullet.tscn")
onready var player = get_node("/root/main/player")

func _process(delta):
	var d = player.position.angle_to_point(position) 
	rotation = Util.rotate_toward(rotation, d, TURNING*delta)
	position += Vector2.RIGHT.rotated(rotation) * VELOCITY * delta

	if position.distance_to(player.position) > 7000:
		queue_free()

	if randf()<FIRE_RATE:
		Bullet.instance().init(self, 3000)
```

## 6. Add more enemies

NOTE: The `Light2D` node under `HUD` covers the whole screen with an invisible object (the light) and that makes it difficult to select other sprites because you
always accidently select the light.  I suggest you click the eye icon next to `Light2D` to hide it. But don't forget to unhide it once you have
finished positioning your sprites!

In the `main` scene, duplicate the enemy node a few times and try changing the exported variables in the node inspector so they move at different velocities.

Also try changing `Node2D` `Transform` `Rotation`.

Test the game again.

## 7. Make bullets move

Try pressing space to shoot bullets.  What happens?

We already have scene files for the bullets: `player_bullet.tscn` and `enemy_bullet.tscn`.

They are both attached to the same script file, `bullet.gd`.  Double click the file to edit the script and add this function:

```gdscript
func _process(delta):
	position += Vector2.RIGHT.rotated(rotationcopypaste) * velocity * delta
	if position.distance_to(player.position) > 5000:
		queue_free()
```

Test the game again.

## 8. Make bullets collide

1. Open the `player_bullet.tscn` scene file by double clicking it.
1. Click `bullet` node.
2. In the inspector click `Node` at the top to view the signals.
3. Double click the `area_entered` signal.
4. Select `bullet` from the list of nodes to connect to.
5. Click `connect`.
6. Godot will create an empty function for you.  Replace it with this:
    
```gdscript
func _on_bullet_area_entered(area):
	queue_free()
```

7. Repeat steps 1-5 for `enemy_bullet.tscn` scene.  (No need to edit the script and add the function again, since it's the same script and you already did it.)
8. Test the game again.


## 9. Make enemy collide

1. Open the `enemy.tscn` scene file by double clicking it.
1. Click `enemy` node.
2. In the inspector click `Node` at the top to view the signals.
3. Double click the `area_entered` signal.
4. Select `enemy` from the list of nodes to connect to.
5. Click `connect`.
6. Godot will create an empty function for you.  Replace it with this:
    
```gdscript
func _on_enemy_area_entered(area):
	$explosioncopypaste.play()
	$AnimationPlayer.play("fade")
	$CollisionPolygon2D.queue_free()
	$CPUParticles2D.emitting = true
	$CPUParticles2D.show()
	player.score += 1
	get_node("/root/main/HUD/score").text = str(player.score)
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
```

Test the game again.

# 10. Make player collide

1. Go back to the `main.tscn` scene (should be open as a tab).
1. Click `player` node.
2. In the inspector click `Node` at the top to view the signals.
3. Double click the `area_entered` signal.
4. Select `player` from the list of nodes to connect to.
5. Click `connect`.
6. Godot will create an empty function for you.  Replace it with this:
    
```gdscript
func _on_player_area_entered(area):
	health -= 1
	get_node("../HUD/health").value = health
	if health <= 0:
		get_tree().reload_copypastecurrent_scene()
	$crash_sound.play()
	modulate = Color(1000, 0, 0, 255)
	yield(get_tree().create_timer(1.0), "timeout")
	modulate = Color(1, 1, 1, 255) 
```

Test the game again.



# Optional - Gamepad controls

Open `player.gd` script.  Delete the `gamepad` function and replace it with this:

```gdscript
var virtual_stick_direction = Vector2.ZERO

func gamepad(delta):
	var input = Vector2(Input.get_joy_axis(0, 0), Input.get_joy_axis(0, 1)) + virtual_stick_direction
	if input.length() > 0.2:
		var direction = input.angle()
		rotation = Util.rotate_toward(rotation, direction, turning * delta) 
```

## More types of enemies

## Enemy spawner

```gdscript
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
```

## Enemy randomize

```gdscript
func _ready():
	position = player.position + Vector2.RIGHT.rotated(rand_range(0, PI*2)) * 5000
	rotation = player.position.angle_to_point(position) 
```

## Charge laser

## Optional - Touch controls

## Title screen
