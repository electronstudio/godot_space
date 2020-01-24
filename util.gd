extends Reference

class_name Util

static func lerp_angle(from, to, weight):
    return from + short_angle_dist(from, to) * weight

static func short_angle_dist(from, to):
    var max_angle = PI * 2
    var difference = fmod(to - from, max_angle)
    return fmod(2 * difference, max_angle) - difference

static func rotate_toward(from, to, amount):
	var d = short_angle_dist(from, to)
	if d > 0:
		return from + amount
	elif d < 0:
		return from - amount
	else:
		return to