class_name PostureSegment

var reference: Quaternion = Quaternion.IDENTITY
var measured: Quaternion = Quaternion.IDENTITY

func set_reference(q: Quaternion):
	reference = q.normalized()

func set_measured(q: Quaternion):
	measured = q.normalized()

func relative_quaternion() -> Quaternion:
	return QuaternionUtils.relative(measured, reference)

func deviation() -> Dictionary:
	return QuaternionUtils.to_axis_angle(relative_quaternion())
