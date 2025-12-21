extends Control

@export var score_label: Label
@export var status_label: Label
@export var progress: ProgressBar

func update_score(score: float):
	progress.value = score * 100.0
	score_label.text = "Posture Score: %d%%" % int(score * 100)

func update_status(text: String):
	status_label.text = text
	
