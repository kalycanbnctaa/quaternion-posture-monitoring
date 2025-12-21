class_name PostureTimer

# Threshold hysteresis (radians)
@export var enter_threshold := deg_to_rad(15)  
@export var exit_threshold  := deg_to_rad(12)  

@export var duration := 3.0  

var elapsed := 0.0
var is_bad_posture := false


func update(angle: float, delta: float) -> bool:
	if not is_bad_posture:
		if angle > enter_threshold:
			is_bad_posture = true
			elapsed = 0.0
	else:
		if angle < exit_threshold:
			is_bad_posture = false
			elapsed = 0.0
		else:
			elapsed += delta

	return is_bad_posture and elapsed >= duration
