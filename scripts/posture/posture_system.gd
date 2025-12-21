class_name PostureSystem

var analyzer := PostureAnalyzer.new()

var segments := {
	"neck": PostureSegment.new(),
	"upper_spine": PostureSegment.new(),
	"lower_spine": PostureSegment.new()
}

func setup():
	for name in segments.keys():
		segments[name].set_reference(Quaternion.IDENTITY)
		analyzer.add_segment(name, segments[name])

func set_measured(name: String, q: Quaternion):
	segments[name].set_measured(q)

func analyze() -> Dictionary:
	return analyzer.analyze()

func overall_score(results: Dictionary) -> float:
	var sum := 0.0
	for r in results.values():
		sum += PostureMetrics.posture_score(r.angle)
	return sum / results.size()
