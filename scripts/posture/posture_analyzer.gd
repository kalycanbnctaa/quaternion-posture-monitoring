class_name PostureAnalyzer

var segments := {}

func add_segment(name: String, segment: PostureSegment):
	segments[name] = segment

func analyze() -> Dictionary:
	var results := {}
	for name in segments.keys():
		results[name] = segments[name].deviation()
	return results
