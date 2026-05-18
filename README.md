<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=12,20,24&height=180&section=header&text=Quaternion%20Posture%20Monitoring&fontSize=32&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=3D%20Orientation%20Analysis%20for%20Human%20Posture%20Detection&descAlignY=58&descSize=15&descColor=a78bfa" width="100%"/>

[![GDScript](https://img.shields.io/badge/GDScript-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![Godot](https://img.shields.io/badge/Godot%20Engine-3D-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![Math](https://img.shields.io/badge/Quaternion%20Algebra-SO(3)-8b5cf6?style=for-the-badge)](https://en.wikipedia.org/wiki/Quaternion)
[![FPS](https://img.shields.io/badge/60%20FPS-Real%20Time-4ade80?style=for-the-badge)](.)
[![Latency](https://img.shields.io/badge/Latency-%3C16ms-ec4899?style=for-the-badge)](.)
[![License](https://img.shields.io/badge/License-Academic-06b6d4?style=for-the-badge)](.)

<br>

> *A quaternion-based system for real-time human upper-body posture detection, correction, and visualization — built without singularities, without compromise.*

</div>

---

## ![Overview](https://img.shields.io/badge/-%20Overview-8b5cf6?style=flat-square&labelColor=0a0520)

This project presents a **quaternion-based posture monitoring system** designed to detect, evaluate, and correct human upper-body posture using mathematically robust 3D orientation representations. The system models body segments as vectors in ℝ³ and represents their orientations using **unit quaternions**, enabling stable posture analysis free from singularities such as gimbal lock.

The implementation focuses on **real-time posture deviation detection**, **semantic feedback**, **temporal smoothing**, and **visual correction cues**, making it suitable for lightweight health monitoring applications and educational demonstrations of quaternion algebra.

---

## ![Key Features](https://img.shields.io/badge/-%20Key%20Features-7c3aed?style=flat-square&labelColor=0a0520)

| Feature | Description |
|--------|-------------|
| **Quaternion Orientation** | Unit quaternions for stable 3D rotation, avoids gimbal lock |
| **Relative Quaternion Analysis** | Detects posture deviation via relative quaternion computation |
| **Posture Correction** | Corrective quaternion using inverse rotation, smoothed with SLERP |
| **Temporal Stability** | Exponential smoothing for noise reduction |
| **FSM Posture Status** | Classifies posture into Good, Fair, and Poor states |
| **Semantic Feedback** | Human-readable deviation feedback, e.g. Forward Head Posture |
| **3D Visual Feedback** | Color-coded arrows for deviation and correction direction |
| **Error History** | Posture deviation trends over time for convergence analysis |

---

## ![System Architecture](https://img.shields.io/badge/-%20System%20Architecture-3b82f6?style=flat-square&labelColor=0a0520)

```text
quaternion-posture-monitoring/
│
├── scripts/
│   ├── controller/
│   │   └── posture_controller.gd       # Main system coordinator
│   │
│   ├── math/
│   │   ├── quaternion_utils.gd         # Quaternion algebra utilities
│   │   └── posture_metrics.gd          # Scoring and geodesic distance
│   │
│   ├── posture/
│   │   ├── posture_segment.gd          # Body segment representation
│   │   ├── posture_analyzer.gd         # Deviation computation
│   │   └── posture_corrector.gd        # SLERP-based correction
│   │
│   └── visualization/
│       └── deviation_visualizer.gd     # 3D arrow and color feedback
│
├── shaders/
│   └── quaternion_rotation.gdshader    # GPU-accelerated rotation shader
│
├── README.md
└── project.godot
```

---

## ![Core Modules](https://img.shields.io/badge/-%20Core%20Modules-ec4899?style=flat-square&labelColor=0a0520)

### PostureSegment
Represents an individual body segment (e.g., neck, upper spine) with reference and measured orientations, supporting relative quaternion computation and temporal smoothing.

### PostureAnalyzer
Computes relative quaternions, deviation angles, and posture metrics for each body segment.

### PostureSystem
Coordinates multi-segment posture analysis, weighted scoring, FSM-based posture classification, and history logging.

### DeviationVisualizer
Provides real-time 3D visualization of posture deviation and correction vectors using arrows and color-coded feedback.

### PostureMetrics
Contains mathematical utilities for posture scoring, geodesic distance computation, and semantic posture interpretation.

---

## ![Simulation Scenarios](https://img.shields.io/badge/-%20Simulation%20Scenarios-06b6d4?style=flat-square&labelColor=0a0520)

The system supports multiple simulation scenarios for evaluation:

| Scenario | Description |
|----------|-------------|
| Ideal posture | Zero deviation baseline |
| Forward head posture | Common screen-related deviation |
| Slouching posture | Lower spine deviation pattern |
| Sudden posture change | Step response analysis |
| Noisy input | Temporal smoothing under noise |
| Gradual correction | SLERP convergence validation |

---

## ![Performance](https://img.shields.io/badge/-%20Performance-4ade80?style=flat-square&labelColor=0a0520)

<div align="center">

| Metric | Result |
|--------|--------|
| Real-time operation | 60 FPS |
| System latency | < 16 ms |
| Quaternion stability | Robust under noisy input |
| Posture states | Good, Fair, Poor |
| Output score range | 0 — 100% |

</div>

---

## ![Output](https://img.shields.io/badge/-%20Output%20%26%20Visualization-a78bfa?style=flat-square&labelColor=0a0520)

The system outputs real-time feedback through multiple channels:

- **Posture Score** — 0 to 100%, reflects overall posture quality
- **Posture Status** — Good, Fair, or Poor via FSM classification
- **Semantic Feedback** — e.g., *"Detected issue: Forward Head Posture"*
- **3D Visual Indicators** — Red arrow for deviation, blue arrow for correction
- **Error History Timeline** — Deviation trends for convergence analysis

> This makes the system suitable for both **academic analysis** and **user-oriented health monitoring applications**.

---

## ![Demo](https://img.shields.io/badge/-%20Screenshots%20%26%20Demo-ec4899?style=flat-square&labelColor=0a0520)

> Add screenshots or a demo GIF here to showcase the 3D visualization and posture feedback in action.

```
[ screenshot or GIF of the 3D posture visualization ]
[ screenshot of posture score output ]
[ screenshot of error history graph ]
```

*To add: drag and drop your screenshots into this section when editing on GitHub.*

---

## ![Tech Stack](https://img.shields.io/badge/-%20Tech%20Stack-7c3aed?style=flat-square&labelColor=0a0520)

![GDScript](https://img.shields.io/badge/GDScript-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)
![Godot](https://img.shields.io/badge/Godot%20Engine-3D-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)
![Math](https://img.shields.io/badge/Quaternion%20Algebra-8b5cf6?style=for-the-badge)
![Visualization](https://img.shields.io/badge/Real--time%20Visualization-3b82f6?style=for-the-badge)

---

## ![Academic Background](https://img.shields.io/badge/-%20Academic%20Background-06b6d4?style=flat-square&labelColor=0a0520)

This project is grounded in quaternion algebra and three-dimensional rotation theory, developed as part of coursework in **Aljabar Linear dan Geometri** at Institut Teknologi Bandung.

**References:**
- R. Munir, *Aljabar Quaternion*, Institut Teknologi Bandung
- Quaternion-based orientation analysis literature
- Human posture monitoring research

---

## ![Future Improvements](https://img.shields.io/badge/-%20Future%20Improvements-4ade80?style=flat-square&labelColor=0a0520)

- Integration with real IMU sensor data
- Machine learning-based posture classification
- Multi-user posture tracking
- Wearable and mobile platform deployment

---

## ![Author](https://img.shields.io/badge/-%20Author-a78bfa?style=flat-square&labelColor=0a0520)

<div align="center">

**Kalyca Nathania Benedicta Manullang**

[![ITB](https://img.shields.io/badge/Institut%20Teknologi%20Bandung-Computer%20Science-3b82f6?style=for-the-badge)](https://www.itb.ac.id/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kalyca-nathania-benedicta-manullang/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/kalycanbnctaa)
[![Email](https://img.shields.io/badge/Email-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:kalycamanullang@gmail.com)

*Algebra Linear dan Geometri Project — Institut Teknologi Bandung*

</div>

---

<div align="center">

![Visitor Count](https://komarev.com/ghpvc/?username=kalycanbnctaa&color=8b5cf6&style=for-the-badge&label=REPO+VIEWS)

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=12,20,24&height=120&section=footer&animation=fadeIn" width="100%"/>

</div>
