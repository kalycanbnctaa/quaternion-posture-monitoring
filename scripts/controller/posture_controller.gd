@export var system: PostureSystem
@export var visualizer: DeviationVisualizer
@export var dashboard: Control

@export var simulated_axis := Vector3(1, 0, 0)
@export var simulated_angle_deg := 20.0

var timer := PostureTimer.new()

func _ready():
	system.setup()

func _process(delta):
	# SIMULASI POSTURE (CONFIGURABLE)
	var axis := simulated_axis.normalized()
	var angle := deg_to_rad(simulated_angle_deg)

	system.set_measured(
		"upper_spine",
		Quaternion(axis, angle)
	)

	# ANALYSIS
	var results := system.analyze()
	if not results.has("upper_spine"):
		return

	var main := results["upper_spine"]

	# VISUALIZATION
	visualizer.visualize(main.axis, main.angle)

	# SLERP-BASED SMOOTH CORRECTION
	if timer.update(main.angle, delta):
		var segment := system.segments["upper_spine"]

		var q_current := segment.measured
		var q_target := segment.reference   # ideal posture

		var t := clamp(delta * 2.0, 0.0, 1.0)
		var q_smooth := q_current.slerp(q_target, t)

		segment.set_measured(q_smooth)

	# DASHBOARD
	var score := system.overall_score(results)
	var status := system.posture_status(score)

	dashboard.update_score(score)
	dashboard.update_status(status)

