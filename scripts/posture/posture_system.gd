class_name PostureSystem

var analyzer := PostureAnalyzer.new()

# Weight contribution of each body segment
# Higher weight means greater influence on posture quality
var segment_weights := {
	"neck": 0.3,
	"upper_spine": 0.5,
	"lower_spine": 0.2
}

var segments := {
	"neck": PostureSegment.new(),
	"upper_spine": PostureSegment.new(),
	"lower_spine": PostureSegment.new()
}

# CONVERGENCE HISTORY (RESEARCH FEATURE) 
var history := []   # [{time, angle, geo}]


func setup():
	for name in segments.keys():
		segments[name].set_reference(Quaternion.IDENTITY)
		analyzer.add_segment(name, segments[name])


func set_measured(name: String, q: Quaternion):
	segments[name].set_measured(q)


func analyze() -> Dictionary:
	return analyzer.analyze()


# LOG SYSTEM STATE FOR CONVERGENCE ANALYSIS
func log_state(time: float, q_rel: Quaternion):
	history.append({
		"time": time,
		"angle": 2.0 * acos(clamp(q_rel.w, -1.0, 1.0)),
		"geo": PostureMetrics.geodesic_distance(q_rel)
	})


func overall_score(results: Dictionary) -> float:
	if results.is_empty():
		return 1.0

	var weighted_sum := 0.0
	var total_weight := 0.0

	for name in results.keys():
		var w := segment_weights.get(name, 1.0)

		var q_rel := segments[name].relative_quaternion()

		# 1) Axis-angle based score
		var angle := results[name].angle
		var angle_score := PostureMetrics.posture_score(angle)

		# 2) Geodesic distance based score
		var d := PostureMetrics.geodesic_distance(q_rel)
		var geo_score := clamp(1.0 - d / PI, 0.0, 1.0)

		# Combine both metrics
		var score := 0.5 * angle_score + 0.5 * geo_score

		weighted_sum += w * score
		total_weight += w

	return weighted_sum / total_weight


func posture_status(score: float) -> String:
	if score > 0.9:
		return "Good Posture"
	elif score > 0.7:
		return "Fair Posture"
	else:
		return "Poor Posture"
