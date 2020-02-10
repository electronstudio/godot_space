extends Area2D

var charge = 0.0

enum  {CHARGING, DISCHARGING}
var laser = DISCHARGING

func _process(delta):
	if Input.is_action_just_pressed("fire") and charge < 0.01:
		laser = CHARGING
	if Input.is_action_just_released("fire"):
		laser = DISCHARGING
	if laser == CHARGING:
		charge += delta
	elif laser == DISCHARGING:
		charge -= delta
		if charge > 0.3:
			show()
			monitorable = true
		else:
			hide()
			monitorable = false
	charge = clamp(charge, 0.0, 3.0)
	get_node("/root/main/HUD/charge").value = charge