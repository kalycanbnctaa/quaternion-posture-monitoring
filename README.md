# Quaternion-Based Posture Monitoring System

Quaternion-based detection and correction of human upper-body posture for a health monitoring system, implemented using three-dimensional orientation analysis and real-time visualization.

---

## Overview

This project presents a **quaternion-based posture monitoring system** designed to detect, evaluate, and correct human upper-body posture using mathematically robust 3D orientation representations. The system models body segments as vectors in ℝ³ and represents their orientations using **unit quaternions**, enabling stable posture analysis without singularities such as gimbal lock.

The implementation focuses on **real-time posture deviation detection**, **semantic feedback**, **temporal smoothing**, and **visual correction cues**, making it suitable for lightweight health monitoring applications and educational demonstrations of quaternion algebra.

---

## Key Features

- **Quaternion-Based Orientation Representation**
  - Uses unit quaternions for stable 3D rotation modeling
  - Avoids Euler angle singularities and numerical drift

- **Relative Quaternion Posture Analysis**
  - Detects posture deviation via relative quaternion computation
  - Extracts deviation axis and angle using axis–angle representation

- **Posture Correction Mechanism**
  - Computes corrective quaternion using inverse relative rotation
  - Applies smooth correction using quaternion SLERP

- **Temporal Stability Filtering**
  - Reduces noise through exponential smoothing of quaternion updates

- **Finite State Machine (FSM) Posture Status**
  - Classifies posture into: `Good`, `Fair`, and `Poor`
  - Based on weighted multi-segment posture scoring

- **Semantic Posture Feedback**
  - Interprets dominant deviation axis into human-readable feedback
  - Example: *Detected issue: Forward head posture*

- **3D Visual Feedback**
  - Red arrow: posture deviation direction
  - Blue arrow: correction direction
  - Color-coded posture status (green / yellow / red)

- **Error History Visualization**
  - Displays posture deviation trends over time
  - Supports convergence and stability analysis

---

## System Architecture

The system is structured into modular components to ensure clarity, extensibility, and maintainability.

```text
quaternion-posture-monitoring/
│
├── scripts/
│   ├── controller/
│   │   └── posture_controller.gd
│   │
│   ├── math/
│   │   ├── quaternion_utils.gd
│   │   └── posture_metrics.gd
│   │
│   ├── posture/
│   │   ├── posture_segment.gd
│   │   ├── posture_analyzer.gd
│   │   └── posture_corrector.gd
│   │
│   └── visualization/
│       └── deviation_visualizer.gd
│
├── shaders/
│   └── quaternion_rotation.gdshader
│
├── README.md
└── project.godot
```


---

## Core Modules Description

### `PostureSegment`
Represents an individual body segment (e.g., neck, upper spine) with reference and measured orientations, supporting relative quaternion computation and temporal smoothing.

### `PostureAnalyzer`
Computes relative quaternions, deviation angles, and posture metrics for each body segment.

### `PostureSystem`
Coordinates multi-segment posture analysis, weighted scoring, FSM-based posture classification, and history logging.

### `DeviationVisualizer`
Provides real-time 3D visualization of posture deviation and correction vectors using arrows and color-coded feedback.

### `PostureMetrics`
Contains mathematical utilities for posture scoring, geodesic distance computation, and semantic posture interpretation.

---

## Simulation & Evaluation

The system supports multiple simulation scenarios:

- Ideal posture (zero deviation)
- Forward head posture
- Slouching posture
- Sudden posture change (step response)
- Noisy input with temporal smoothing
- Gradual posture correction convergence

Performance evaluation shows:

- Stable real-time operation at **60 FPS**
- Total system latency **< 16 ms**
- Robust quaternion computation under noisy conditions

---

## Output & Visualization

The system outputs:

- **Posture Score** (0–100%)
- **Posture Status** (Good / Fair / Poor)
- **Semantic Feedback** (e.g., Forward Head Posture)
- **3D Visual Indicators**
- **Error History Timeline**

This makes the system suitable for both **academic analysis** and **user-oriented health monitoring applications**.

---

## Technologies Used

- **Language:** GDScript
- **Engine:** Godot Engine (3D)
- **Mathematics:** Quaternion algebra, SO(3) rotations
- **Visualization:** Real-time 3D arrows and color mapping

---

## Academic Background

This project is grounded in quaternion algebra and three-dimensional rotation theory, inspired by coursework in **Algebra Linear dan Geometri** and supported by references including:

- R. Munir, *Aljabar Quaternion*, Institut Teknologi Bandung
- Quaternion-based orientation analysis literature
- Human posture monitoring research

---

## Future Improvements

Possible extensions include:

- Integration with real IMU sensor data
- Machine learning-based posture classification
- Multi-user posture tracking
- Wearable and mobile platform deployment

---

## Author

**Kalyca Nathania Benedicta Manullang**  
Institut Teknologi Bandung  
Algebra Linear dan Geometri Project

---

## License

This project is intended for **academic and educational use**.


