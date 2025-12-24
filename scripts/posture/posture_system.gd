extends Node
class_name PostureSystem

enum PostureState {
	GOOD,
	FAIR,
	POOR
}

var current_state: PostureState = PostureState.GOOD

var analyzer: PostureAnalyzer = PostureAnalyzer.new()

var segments := {
	"neck": PostureSegment.new(),
	"upper_spine": PostureSegment.new(),
	"lower_spine": PostureSegment.new()
}

var segment_weights := {
	"neck": 0.3,
	"upper_spine": 0.5,
	"lower_spine": 0.2
}

var history: Array = []
var max_history: int = 300

var enter_fair: float = 0.85
var exit_fair: float = 0.90
var enter_poor: float = 0.65
var exit_poor: float = 0.75


func setup() -> void:
	for name in segments.keys():
		segments[name].set_reference(Quaternion.IDENTITY)
		analyzer.add_segment(name, segments[name])


func set_measured(name: String, q: Quaternion) -> void:
	if segments.has(name):
		segments[name].set_measured(q)


func analyze() -> Dictionary:
	return analyzer.analyze()


func log_state(time: float, q_rel: Quaternion) -> void:
	var angle: float = 2.0 * acos(clamp(q_rel.w, -1.0, 1.0))
	var geo: float = PostureMetrics.geodesic_distance(q_rel)

	history.append({
		"time": time,
		"angle": angle,
		"geo": geo
	})

	if history.size() > max_history:
		history.pop_front()


func get_error_history() -> Array:
	return history


func overall_score(results: Dictionary) -> float:
	if results.is_empty():
		return 1.0

	var weighted_sum: float = 0.0
	var total_weight: float = 0.0

	for name in results.keys():
		if not segments.has(name):
			continue

		var weight: float = segment_weights.get(name, 1.0)
		var q_rel: Quaternion = segments[name].relative_quaternion()

		var angle: float = results[name].angle
		var angle_score: float = PostureMetrics.posture_score(angle)

		var geo_dist: float = PostureMetrics.geodesic_distance(q_rel)
		var geo_score: float = clamp(1.0 - geo_dist / PI, 0.0, 1.0)

		var score: float = 0.5 * angle_score + 0.5 * geo_score

		weighted_sum += weight * score
		total_weight += weight

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

	var q_rel: Quaternion = segments[name].relative_quaternion()
	return PostureMetrics.semantic_feedback(q_rel)


func confidence_level(window: int = 10) -> float:
	if history.size() < window:
		return 0.0

	var recent: Array = history.slice(history.size() - window, history.size())

	var mean: float = 0.0
	for h in recent:
		mean += h["angle"]
	mean /= recent.size()

	var variance: float = 0.0
	for h in recent:
		variance += pow(h["angle"] - mean, 2)
	variance /= recent.size()

	var stability: float = 1.0 / (1.0 + variance * 10.0)
	var magnitude: float = clamp(1.0 - mean / deg_to_rad(30.0), 0.0, 1.0)

	return clamp(0.5 * stability + 0.5 * magnitude, 0.0, 1.0)
