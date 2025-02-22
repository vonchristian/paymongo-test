# 🚗 Object-Oriented Parking System

## 📖 Overview
The **Object-Oriented Parking System** is designed for **Ayala Corp.'s** new **Object-Oriented Mall**. It **automates parking slot assignment** based on vehicle size and proximity to entry points. The system also **calculates fees** based on a tiered pricing structure, including continuous rate policies for re-entry within an hour.

## ✨ Features

### 🅿️ **Smart Parking Allocation**
- Vehicles are **automatically assigned** the nearest available slot.
- Three (3) **entry points** determine the shortest parking distance.
- **Slot compatibility by vehicle type**:
  - 🚗 **Small (S)** → Can park in **SP, MP, LP** slots.
  - 🚙 **Medium (M)** → Can park in **MP, LP** slots.
  - 🛻 **Large (L)** → Can only park in **LP** slots.

### 💰 **Parking Fee Calculation**
- **Flat rate**: **₱40** for the **first 3 hours**.
- **Hourly rates** for additional time:
  - 🅿️ **SP (Small Parking)** → **₱20/hour**
  - 🚙 **MP (Medium Parking)** → **₱60/hour**
  - 🚛 **LP (Large Parking)** → **₱100/hour**
- **₱5000 per full 24-hour chunk** (flat rate).
- **Continuous rate** applies if a vehicle exits and re-enters **within 1 hour**.

## 🛠️ Setup Guide

### **1️⃣ Install Dependencies**
Ensure you have **Ruby 3.2+**, **Rails 8**, and **PostgreSQL** installed.
```sh
# Install required gems
bundle install

# Setup database
rails db:setup
```

### **2️⃣ Start the Application**
Run the Rails server:
```sh
bin/dev
```
App will be available at: **http://localhost:3000**

### **3️⃣ Run Tests**
Ensure everything is working by running:
```sh
bundle exec rspec
```

## 🚀 Future Enhancements
- **🔍 Live Parking Slot Availability UI**
- **💳 Payment Integration (Stripe, GCash, Maya)**
- **🎟️ Discount & Membership Pricing**

