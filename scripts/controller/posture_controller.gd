extends Node

@export var visualizer: DeviationVisualizer

var analyzer := PostureAnalyzer.new()
var spine := PostureSegment.new()

func _ready():
	spine.set_reference(Quaternion.IDENTITY)
	analyzer.add_segment("spine", spine)

func _process(delta):
	# SIMULASI POSTUR SALAH
	var simulated = Quaternion(Vector3(1, 0, 0), deg_to_rad(20))
	spine.set_measured(simulated)

	var results = analyzer.analyze()
	var dev = results["spine"]

	visualizer.visualize(dev.axis, dev.angle)

	var score = PostureMetrics.posture_score(dev.angle)
	print("Posture score:", score)
