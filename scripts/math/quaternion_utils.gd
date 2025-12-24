class_name QuaternionUtils

static func normalize(q: Quaternion) -> Quaternion:
	return q.normalized()

static func relative(q_measured: Quaternion, q_reference: Quaternion) -> Quaternion:
	return (q_reference.inverse() * q_measured).normalized()

static func to_axis_angle(q: Quaternion) -> Dictionary:
	var w = clamp(abs(q.w), -1.0, 1.0)
	var angle = 2.0 * acos(w)
	var s = sqrt(1.0 - w * w)

	var axis: Vector3
	if s < 0.0001:
		axis = Vector3(1, 0, 0)
	else:
		axis = Vector3(q.x, q.y, q.z) / s

	return {
		"axis": axis,
		"angle": angle
	}
