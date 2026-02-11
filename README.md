# 🏭 Fouladh SmartControl

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Prototype-green)

## 📖 Project Overview

**Fouladh SmartControl** is an industrial mobile application designed to digitize the supervision process within the **EL FOULADH** steel factory. 

The app allows supervisors to monitor machine states in real-time and perform remote control actions (Start/Stop) securely across three main departments:
* **DEA** (Aciérie)
* **DEL** (Laminoirs)
* **DTF** (Tréfilerie)

This project was developed as part of an End-of-Studies Project (PFE), aiming to replace legacy manual monitoring with a modern **IoT-ready solution**.

---

## 🚀 Key Features

* **🔐 Secure Authentication:** Role-based access control (Admin/Supervisor) with encrypted credentials.
* **📊 Real-Time Monitoring:** Visual dashboard showing the live status of machines (Running/Stopped).
* **🎛️ Remote Control:** Ability to send "Open" or "Close" commands to machines via a local API.
* **⚠️ Safety Mechanisms:** Mandatory confirmation pop-ups before critical actions to prevent accidents.
* **📜 Audit Logs:** Automatic history tracking of all user actions for security and traceability.
* **🌙 Dark Mode:** Optimized UI for low-light industrial environments.

---

## 🛠️ Tech Stack & Architecture

This project follows a **3-Tier Architecture**:

1.  **Frontend (Mobile):** * Framework: **Flutter** (Dart)
    * State Management: `setState` (or Provider/Bloc if used)
    * HTTP Client: `http` package
2.  **Backend (API):**
    * Language: **PHP** (Native)
    * Server: **Apache** (via XAMPP/WAMP)
    * Communication: JSON REST API
3.  **Database:**
    * Engine: **MySQL** (Relational Data Model)
    * Hosting: Local On-Premise Server

---

## 📸 Screenshots

| Login Screen | Dashboard (DEA) | Control Popup |
|:---:|:---:|:---:|
| <img src="screenshots/login.png" width="200"> | <img src="screenshots/dashboard.png" width="200"> | <img src="screenshots/popup.png" width="200"> |

*(Note: Add your actual screenshots in a folder named `screenshots`)*

---

## ⚙️ Installation & Setup

To run this project locally, follow these steps:

### 1. Backend Setup (XAMPP)
1.  Install **XAMPP** or WAMP.
2.  Start **Apache** and **MySQL**.
3.  Import the database file `fouladh_db.sql` (located in `/database` folder) into phpMyAdmin.
4.  Copy the `api` folder into `htdocs`.
5.  Configure your IP address in `db_connect.php`.

### 2. Mobile App Setup (Flutter)
1.  Clone the repo:
    ```bash
    git clone [https://github.com/your-username/fouladh-smartcontrol.git](https://github.com/your-username/fouladh-smartcontrol.git)
    ```
2.  Navigate to the project directory:
    ```bash
    cd fouladh-smartcontrol
    ```
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Update the API URL in `lib/constants.dart` (or wherever you stored it) to match your PC's local IP:
    ```dart
    const String baseUrl = "[http://192.168.1.](http://192.168.1.)X/fouladh_api/";
    ```
5.  Run the app:
    ```bash
    flutter run
    ```

---

## 🤝 Contribution

This is an academic project. However, suggestions and pull requests are welcome!

## 📄 License

This project is for educational purposes under the context of EL FOULADH.

---
**Author:** [Your Name]  
**Institute:** [Your Institute Name]
