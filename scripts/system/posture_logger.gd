class_name PostureLogger

var file: FileAccess
var is_active := false


func start(path := "user://posture_log.csv"):
	file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		is_active = true
		file.store_line("time,segment,angle,geodesic,qw,qx,qy,qz")


func log(time: float, segment: String, angle: float, q_rel: Quaternion):
	if not is_active:
		return

	var geo := PostureMetrics.geodesic_distance(q_rel)

	file.store_line(
		"%f,%s,%f,%f,%f,%f,%f,%f" % [
			time,
			segment,
			angle,
			geo,
			q_rel.w,
			q_rel.x,
			q_rel.y,
			q_rel.z
		]
	)


func stop():
	if file:
		file.close()
	is_active = false
