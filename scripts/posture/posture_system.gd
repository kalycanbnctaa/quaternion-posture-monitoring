extends Node
class_name PostureSystem

enum PostureState {
	GOOD,
	FAIR,
	POOR
}

var current_state: PostureState = PostureState.GOOD

var analyzer := PostureAnalyzer.new()

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

var history := []

var enter_fair := 0.85
var exit_fair := 0.90
var enter_poor := 0.65
var exit_poor := 0.75


func setup():
	for name in segments.keys():
		segments[name].set_reference(Quaternion.IDENTITY)
		analyzer.add_segment(name, segments[name])


func set_measured(name: String, q: Quaternion):
	if segments.has(name):
		segments[name].set_measured(q)


func analyze() -> Dictionary:
	return analyzer.analyze()


func log_state(time: float, q_rel: Quaternion):
	history.append({
		"time": time,
		"angle": 2.0 * acos(clamp(q_rel.w, -1.0, 1.0)),
		"geo": PostureMetrics.geodesic_distance(q_rel)
	})


func get_error_history() -> Array:
	return history


func overall_score(results: Dictionary) -> float:
	if results.is_empty():
		return 1.0

	var weighted_sum := 0.0
	var total_weight := 0.0

	for name in results.keys():
		if not segments.has(name):
			continue

		var w := segment_weights.get(name, 1.0)
		var q_rel := segments[name].relative_quaternion()

		var angle := results[name].angle
		var angle_score := PostureMetrics.posture_score(angle)

		var d := PostureMetrics.geodesic_distance(q_rel)
		var geo_score := clamp(1.0 - d / PI, 0.0, 1.0)

		var score := 0.5 * angle_score + 0.5 * geo_score

		weighted_sum += w * score
		total_weight += w

	return weighted_sum / total_weight


func update_fsm(score: float) -> void:
	match current_state:
		PostureState.GOOD:
			if score < enter_fair:
				current_state = PostureState.FAIR
		PostureState.FAIR:
			if score < enter_poor:
				current_state = PostureState.POOR
			elif score > exit_fair:
				current_state = PostureState.GOOD
		PostureState.POOR:
			if score > exit_poor:
				current_state = PostureState.FAIR


func get_posture_status() -> String:
	match current_state:
		PostureState.GOOD:
			return "Good Posture"
		PostureState.FAIR:
			return "Fair Posture"
		PostureState.POOR:
			return "Poor Posture"
	return "Unknown"

func semantic_feedback(name: String) -> String:
	if not segments.has(name):
		return "Unknown posture segment"

	var q_rel := segments[name].relative_quaternion()
	return PostureMetrics.semantic_feedback(q_rel)

