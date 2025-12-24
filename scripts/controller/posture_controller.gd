extends Node

@export var system: PostureSystem
@export var visualizer: DeviationVisualizer
@export var dashboard: Control

enum InputMode {
	SIMULATION,
	USER_DEFINED
}

@export var input_mode := InputMode.USER_DEFINED

@export var simulated_axis := Vector3(1, 0, 0)
@export var simulated_angle_deg := 20.0

@export var user_axis := Vector3(1, 0, 0)
@export var user_angle_deg := 15.0

var timer := PostureTimer.new()
var logger := PostureLogger.new()

var time := 0.0


func _ready():
	system.setup()
	logger.start()


func _process(delta):
	time += delta

	var axis: Vector3
	var angle: float

	if input_mode == InputMode.USER_DEFINED:
		axis = user_axis
		angle = deg_to_rad(user_angle_deg)
	else:
		axis = simulated_axis
		angle = deg_to_rad(simulated_angle_deg)

	if axis.length() < 0.0001:
		axis = Vector3(1, 0, 0)

	axis = axis.normalized()

	system.set_measured(
		"upper_spine",
		Quaternion(axis, angle)
	)

	var results := system.analyze()
	if not results.has("upper_spine"):
		return

	var main := results["upper_spine"]

	visualizer.visualize(main.axis, main.angle)

	var segment := system.segments["upper_spine"]
	var q_rel := segment.relative_quaternion()

	logger.log(
		time,
		"upper_spine",
		main.angle,
		q_rel
	)

	system.log_state(time, q_rel)

	if timer.update(main.angle, delta):
		segment.apply_correction(delta * 2.0)

	var score := system.overall_score(results)
	system.update_fsm(score)

	var status := system.get_posture_status()
	var confidence := system.confidence_level()

	dashboard.update_score(score)
	dashboard.update_status(status)
	dashboard.update_confidence(confidence)


func _exit_tree():
	logger.stop()
