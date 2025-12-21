class_name PostureTimer

var threshold_angle := deg_to_rad(15)
var duration := 3.0
var elapsed := 0.0

func update(angle: float, delta: float) -> bool:
	if angle > threshold_angle:
		elapsed += delta
	else:
		elapsed = 0.0
	return elapsed >= duration
