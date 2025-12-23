class_name PostureSegment

var reference: Quaternion = Quaternion.IDENTITY
var measured: Quaternion = Quaternion.IDENTITY
var smoothed: Quaternion = Quaternion.IDENTITY
var smoothing_alpha := 0.2
var initialized := false


func set_reference(q: Quaternion):
	reference = q.normalized()


func set_measured(q: Quaternion):
	var qn := q.normalized()

	if not initialized:
		smoothed = qn
		initialized = true
	else:
		smoothed = smoothed.slerp(qn, smoothing_alpha)

	measured = smoothed


func relative_quaternion() -> Quaternion:
	return (reference.inverse() * measured).normalized()


func deviation() -> Dictionary:
	return QuaternionUtils.to_axis_angle(relative_quaternion())


func corrective_quaternion() -> Quaternion:
	return relative_quaternion().inverse()


func apply_correction(alpha := 0.1):
	var qc := corrective_quaternion()
	measured = measured.slerp(qc * measured, alpha).normalized()
	smoothed = measured
