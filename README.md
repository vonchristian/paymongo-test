# Object-Oriented Parking System

## 🚗 Overview
This project is a **parking allocation system** for the Object-Oriented Mall, developed for **Ayala Corp.** It automatically assigns available parking slots based on proximity to entry points and vehicle size. It also calculates parking fees following a tiered pricing structure.

## 📌 Features
- **Automated Slot Assignment:** Vehicles are assigned to the nearest suitable parking slot.
- **Three Entry Points:** Parking is allocated based on the shortest distance.
- **Vehicle & Slot Compatibility:**
  - Small (S) vehicles can park in SP, MP, and LP slots.
  - Medium (M) vehicles can park in MP and LP slots.
  - Large (L) vehicles can only park in LP slots.
- **Fee Calculation:**
  - Flat **₱40** for the first **3 hours**.
  - Hourly rates:
    - **SP:** ₱20/hour
    - **MP:** ₱60/hour
    - **LP:** ₱100/hour
  - **₱5000 per 24-hour chunk**.
  - Continuous rate applies if a vehicle exits and returns within **1 hour**.

## 🛠️ Setup Guide

### **1. Install Dependencies**
Ensure you have **Ruby 3.2+**, **Rails 8**, and **PostgreSQL** installed:
```sh
# Install dependencies
bundle install

# Set up the database
rails db:create db:migrate db:seed
```

### **2. Start the Server**
Run the Rails server:
```sh
rails server
```
Application runs on **http://localhost:3000**.

### **3. Running Tests**
Run the test suite to ensure everything works:
```sh
rspec
```

## 🚀 API Endpoints
| Method | Endpoint            | Description                 |
|--------|--------------------|-----------------------------|
| POST   | `/park`            | Assigns a vehicle to a slot |
| POST   | `/unpark`          | Unparks a vehicle & calculates fee |
| GET    | `/parking_status`  | Displays all parked vehicles |

## 🏗️ Future Enhancements
- Add a UI for parking visualization.
- Implement discount or membership pricing.
- Support multiple parking complexes.

## 📝 License
This project is **open-source** and available under the **MIT License**.

