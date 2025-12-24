class_name PostureMetrics

static func posture_score(angle: float, max_angle := deg_to_rad(30.0)) -> float:
	return clamp(1.0 - angle / max_angle, 0.0, 1.0)

static func error_energy(q_rel: Quaternion) -> float:
	var w := abs(q_rel.w)
	return 1.0 - w * w

static func geodesic_distance(q: Quaternion) -> float:
	var w := clamp(abs(q.w), -1.0, 1.0)
	return 2.0 * acos(w)

static func semantic_feedback(q_rel: Quaternion) -> String:
	var v := Vector3(q_rel.x, q_rel.y, q_rel.z)

	if v.length() < 0.01:
		return "Posture is well aligned"

	v = v.normalized()

	if abs(v.x) >= abs(v.y) and abs(v.x) >= abs(v.z):
		return "Detected issue: Lateral leaning posture"

	if abs(v.y) >= abs(v.x) and abs(v.y) >= abs(v.z):
		return "Detected issue: Forward head posture"

	if abs(v.z) >= abs(v.x) and abs(v.z) >= abs(v.y):
		return "Detected issue: Slouching posture"

	return "Detected issue: Complex posture deviation"

static func confidence_score(
	angle: float,
	geo_dist: float,
	history: Array
) -> float:
	var angle_conf := clamp(1.0 - angle / deg_to_rad(30.0), 0.0, 1.0)
	var geo_conf := clamp(1.0 - geo_dist / PI, 0.0, 1.0)

	var stability_conf := 1.0
	if history.size() >= 3:
		var mean := 0.0
		for h in history:
			mean += h["angle"]
		mean /= history.size()

		var variance := 0.0
		for h in history:
			variance += pow(h["angle"] - mean, 2)
		variance /= history.size()

		stability_conf = clamp(1.0 - variance / 0.05, 0.0, 1.0)

	return 0.4 * angle_conf + 0.4 * geo_conf + 0.2 * stability_conf
