extends Node3D
class_name DeviationVisualizer

@export var arrow: Node3D
@export var mesh: MeshInstance3D

func visualize(axis: Vector3, angle: float):
	if angle < 0.01:
		arrow.visible = false
		mesh.modulate = Color.GREEN
		return

	arrow.visible = true
	arrow.look_at(arrow.global_position + axis, Vector3.UP)
	arrow.scale.y = angle * 5.0

	if angle < deg_to_rad(10):
		mesh.modulate = Color.GREEN
	elif angle < deg_to_rad(20):
		mesh.modulate = Color.YELLOW
	else:
		mesh.modulate = Color.RED
