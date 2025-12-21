extends Node3D
class_name DeviationVisualizer

# Arrow merah = deviasi (error)
@export var error_arrow: Node3D

# Arrow biru = arah koreksi (correction)
@export var correction_arrow: Node3D

# Mesh tubuh / segmen
@export var mesh: MeshInstance3D


func visualize(axis: Vector3, angle: float):
	# JIKA HAMPIR TIDAK ADA DEViasi
	if angle < 0.01:
		error_arrow.visible = false
		correction_arrow.visible = false
		mesh.modulate = Color.GREEN
		return


	# ERROR VECTOR (MERAH) 
	error_arrow.visible = true
	error_arrow.look_at(
		error_arrow.global_position + axis,
		Vector3.UP
	)
	error_arrow.scale.y = angle * 5.0
	error_arrow.modulate = Color.RED


	# CORRECTION VECTOR (BIRU)
	# Correction = inverse rotation → axis dibalik
	var correction_axis := -axis

	correction_arrow.visible = true
	correction_arrow.look_at(
		correction_arrow.global_position + correction_axis,
		Vector3.UP
	)
	correction_arrow.scale.y = angle * 5.0
	correction_arrow.modulate = Color.CORNFLOWER_BLUE


	# WARNA STATUS POSTURE 
	if angle < deg_to_rad(10):
		mesh.modulate = Color.GREEN
	elif angle < deg_to_rad(20):
		mesh.modulate = Color.YELLOW
	else:
		mesh.modulate = Color.RED
