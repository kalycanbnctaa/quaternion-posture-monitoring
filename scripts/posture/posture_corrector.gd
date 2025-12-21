extends Node3D
class_name DeviationVisualizer

@export var arrow: Node3D

func visualize(axis: Vector3, angle: float):
	if angle < 0.001:
		arrow.visible = false
		return

	arrow.visible = true
	arrow.look_at(arrow.global_position + axis, Vector3.UP)
	arrow.scale.y = angle
