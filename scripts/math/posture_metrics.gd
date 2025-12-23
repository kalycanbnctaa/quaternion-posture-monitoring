class_name PostureMetrics

static func posture_score(angle: float, max_angle := deg_to_rad(30)) -> float:
	return clamp(1.0 - angle / max_angle, 0.0, 1.0)

static func error_energy(q_rel: Quaternion) -> float:
	return 1.0 - q_rel.w * q_rel.w

static func geodesic_distance(q: Quaternion) -> float:
	# Geodesic distance on SO(3)
	# d(q) = || log(q) || = 2 * acos(|w|)
	var w := clamp(q.w, -1.0, 1.0)
	return abs(2.0 * acos(w))

static func semantic_feedback(q_rel: Quaternion) -> String:
	var axis := Vector3(q_rel.x, q_rel.y, q_rel.z)

	if axis.length() < 0.01:
		return "Posture is well aligned"

	axis = axis.normalized()

	if abs(axis.x) > abs(axis.y) and abs(axis.x) > abs(axis.z):
		return "Detected issue: Lateral leaning posture"

	if abs(axis.y) > abs(axis.x) and abs(axis.y) > abs(axis.z):
		return "Detected issue: Forward head posture"

	if abs(axis.z) > abs(axis.x) and abs(axis.z) > abs(axis.y):
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
		var variance := 0.0
		var mean := 0.0
		for h in history:
			mean += h["angle"]
		mean /= history.size()

		for h in history:
			variance += pow(h["angle"] - mean, 2)
		variance /= history.size()

		stability_conf = clamp(1.0 - variance / 0.05, 0.0, 1.0)

	return 0.4 * angle_conf + 0.4 * geo_conf + 0.2 * stability_conf


