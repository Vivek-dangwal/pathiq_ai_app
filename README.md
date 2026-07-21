# PathIQ AI - Honda Bharat Safety Program
### Flutter Developer Intern Assessment Task

A 4-screen Flutter prototype built for **PathIQ AI**, an AI-powered road-hazard detection and rider-safety system developed under the Honda Bharat Safety Program at AIC IIT Delhi.

---

## 📱 Features & Screen Overview

1. **Screen 1: Dynamic Login / Signup (Role Selector)**
   - Single unified screen supporting both **Rider/User** and **Fleet Manager** roles.
   - Dynamic form field toggling based on selected role and action (Login vs Signup).
   - Form input validation and visual "Forgot Password" functionality.
   - Smart role-based routing (Users navigate to Rider Map, Managers navigate to Fleet Dashboard).

2. **Screen 2: User Home / Live Map Dashboard**
   - Live map visualization displaying interactive road hazards (e.g., Potholes, Waterlogging).
   - Dynamic status badge toggling between `"Detection Active"` and `"Camera Off"`.
   - Real-time mock hazard alert banner (`"! Pothole detected 200m ahead"`).
   - Live rider speed & status widget (`32 km/h`).
   - Bottom navigation bar linking Home Map, Hazard Reporting, and Profile views.

3. **Screen 3: Report Hazard**
   - Selectable hazard category chips (*Pothole*, *Waterlogging*, *Speed Breaker*, *Debris*, *Other*).
   - Auto-filled GPS coordinates for location pinpointing.
   - Multi-option severity selector (*Low*, *Medium*, *High*).
   - Photo attachment simulation with instant UI feedback.
   - Feedback SnackBar confirmation on successful hazard report submission.

4. **Screen 4: Fleet Manager Dashboard**
   - High-level fleet analytics summary cards (*Total Riders*, *Active Now*, *Hazards Reported This Week*).
   - Bird’s-eye fleet overview map with active rider markers.
   - Rider list displaying live status (*Riding / Idle / Offline*) and camera detection state.
   - Interactive rider detail modal (BottomSheet) displaying vehicle info, last known location, and recent hazard reports.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** Flutter (Material 3 UI)
- **State Management:** `StatefulWidget` / `setState` (Lifting state up for local screen interactions and role switching).
- **Architecture Pattern:** Clean Separation of Concerns (UI views, navigation wrappers, and mock data models).

### Why state handling was structured this way:
For this prototype, local state handling (`setState` and parameter passing) was chosen to keep the architecture lightweight, performant, and dependency-free while strictly ensuring state isolation between the Rider flow and the Fleet Manager flow.

---

## ⚙️ How to Run the Project

1. Clone or download this repository:
   ```bash
   git clone <your-repository-url>
   cd pathiq_ai_app
