class_name PostureLogger

var file: FileAccess
var is_active := false


func start(path := "user://posture_log.csv"):
	file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		is_active = true
		file.store_line("time,segment,angle,geodesic")


func log(time: float, segment: String, angle: float, q_rel: Quaternion):
	if not is_active:
		return

	var geo := PostureMetrics.geodesic_distance(q_rel)
	file.store_line(
		"%f,%s,%f,%f" % [time, segment, angle, geo]
	)


func stop():
	if file:
		file.close()
	is_active = false
