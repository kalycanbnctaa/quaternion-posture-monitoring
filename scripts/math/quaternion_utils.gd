class_name QuaternionUtils

static func normalize(q: Quaternion) -> Quaternion:
	return q.normalized()

static func relative(q_measured: Quaternion, q_reference: Quaternion) -> Quaternion:
	return (q_measured * q_reference.inverse()).normalized()

static func to_axis_angle(q: Quaternion) -> Dictionary:
	var w = clamp(q.w, -1.0, 1.0)
	var angle = 2.0 * acos(w)
	var s = sqrt(1.0 - w * w)

	if s < 0.001:
		return {
			"axis": Vector3(1, 0, 0),
			"angle": angle
		}

	return {
		"axis": Vector3(q.x / s, q.y / s, q.z / s),
		"angle": angle
	}
