class_name PostureMetrics

static func posture_score(angle: float, max_angle := deg_to_rad(30)) -> float:
	return clamp(1.0 - angle / max_angle, 0.0, 1.0)

static func error_energy(q_rel: Quaternion) -> float:
	return 1.0 - q_rel.w * q_rel.w
