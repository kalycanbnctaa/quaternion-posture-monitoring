extends Node

@export var system: PostureSystem
@export var visualizer: DeviationVisualizer
@export var dashboard: PostureDashboard  # Ganti Control jadi PostureDashboard

enum InputMode {
    SIMULATION,
    USER_DEFINED
}

@export var input_mode: InputMode = InputMode.SIMULATION
@export var simulated_axis: Vector3 = Vector3(1, 0, 0)
@export var simulated_angle_deg: float = 20.0
@export var user_axis: Vector3 = Vector3(1, 0, 0)
@export var user_angle_deg: float = 15.0

var timer := PostureTimer.new()
var logger := PostureLogger.new()
var time := 0.0

# UI Controls
@onready var mode_button: Button = $UI/ModeButton
@onready var angle_slider: HSlider = $UI/AngleSlider
@onready var axis_x_slider: HSlider = $UI/AxisXSlider
@onready var axis_y_slider: HSlider = $UI/AxisYSlider
@onready var axis_z_slider: HSlider = $UI/AxisZSlider

func _ready():
    if system:
        system.setup()
    logger.start()
    setup_ui()

func setup_ui():
    if mode_button:
        mode_button.text = "Mode: SIMULATION" if input_mode == InputMode.SIMULATION else "Mode: USER"
        mode_button.pressed.connect(_on_mode_button_pressed)
    
    # Setup sliders
    angle_slider.value = simulated_angle_deg
    axis_x_slider.value = simulated_axis.x
    axis_y_slider.value = simulated_axis.y
    axis_z_slider.value = simulated_axis.z

func _on_mode_button_pressed():
    input_mode = InputMode.USER_DEFINED if input_mode == InputMode.SIMULATION else InputMode.SIMULATION
    mode_button.text = "Mode: SIMULATION" if input_mode == InputMode.SIMULATION else "Mode: USER"

func _process(delta):
    time += delta
    
    # Update values from UI
    simulated_angle_deg = angle_slider.value
    simulated_axis = Vector3(
        axis_x_slider.value,
        axis_y_slider.value,
        axis_z_slider.value
    ).normalized()
    
    # Pilih axis dan angle berdasarkan mode
    var axis: Vector3
    var angle: float
    
    if input_mode == InputMode.USER_DEFINED:
        axis = user_axis.normalized()
        angle = deg_to_rad(user_angle_deg)
    else:
        axis = simulated_axis.normalized()
        angle = deg_to_rad(simulated_angle_deg)
    
    # Pastikan axis valid
    if axis.length() < 0.0001:
        axis = Vector3(1, 0, 0)
    axis = axis.normalized()
    
    # Proses posture analysis
    system.set_measured("upper_spine", Quaternion(axis, angle))
    var results := system.analyze()
    
    if not results.has("upper_spine"):
        return
    
    var main := results["upper_spine"]
    visualizer.visualize(main.axis, main.angle)
    
    var segment := system.segments["upper_spine"]
    var q_rel := segment.relative_quaternion()
    
    logger.log(time, "upper_spine", main.angle, q_rel)
    system.log_state(time, q_rel)
    
    if timer.update(main.angle, delta):
        segment.apply_correction(delta * 2.0)
    
    var score := system.overall_score(results)
    system.update_fsm(score)
    var status := system.get_posture_status()
    var confidence := system.confidence_level()
    
    dashboard.update_score(score)
    dashboard.update_status(status)
    dashboard.update_confidence(confidence)

func _exit_tree():
    logger.stop()