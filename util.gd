extends Reference

class_name Util

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
static func lerp_angle(from, to, weight):
    return from + short_angle_dist(from, to) * weight

static func short_angle_dist(from, to):
    var max_angle = PI * 2
    var difference = fmod(to - from, max_angle)
    return fmod(2 * difference, max_angle) - difference
