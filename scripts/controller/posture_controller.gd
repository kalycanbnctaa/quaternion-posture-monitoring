@export var system: PostureSystem
@export var visualizer: DeviationVisualizer
@export var dashboard: Control

var timer := PostureTimer.new()

func _ready():
	system.setup()

func _process(delta):
	# SIMULASI
	system.set_measured("upper_spine",
		Quaternion(Vector3(1,0,0), deg_to_rad(20)))

	var results = system.analyze()
	var main = results["upper_spine"]

	visualizer.visualize(main.axis, main.angle)

	if timer.update(main.angle, delta):
		system.segments["upper_spine"].apply_correction(0.05)

	var score = system.overall_score(results)
	dashboard.update_score(score)
