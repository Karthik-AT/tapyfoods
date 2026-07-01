# 🍽️ Tapy Food — *Taste the Difference, Delivered.*

A fully functional, premium food ordering web application built with **Java Servlets & JSP**, backed by a **MySQL** database, and styled using vanilla CSS.

---

## 📌 Table of Contents

- [🚀 Key Features](#-key-features)
- [🛠️ Tech Stack](#️-tech-stack)
- [🐳 Running Anywhere (Docker - Quickest)](#-running-anywhere-docker---quickest)
- [💻 Local Setup (Eclipse IDE)](#-local-setup-eclipse-ide)
- [🗂️ Project Structure](#️-project-structure)
- [⚙️ Database Setup](#️-database-setup)

---

## 🚀 Key Features

* **Dynamic Menus & Restaurants**: Live filtering, search, and category selection.
* **User Authentication**: Signup/Login validation with styling fixes.
* **Shopping Cart**: Real-time quantity selectors, price subtotaling, and toast feedback.
* **Order History**: Individualized per-user order history tracker with sequential order numbers.
* **Live Order Tracker**: Visual timeline tracking current preparation status.

---

## 🛠️ Tech Stack

* **Backend**: Java (Jakarta Servlet API 6.0, JSP 3.0)
* **Frontend**: HTML5, Vanilla CSS, Vanilla JavaScript (ES6+)
* **Database**: MySQL 8.0
* **Server**: Apache Tomcat 10.1+
* **Environment Configuration**: Supported via system environment variables

---

## 🐳 Running Anywhere (Docker - Quickest)

You can run the web app and database instantly on any OS without manually installing Java, Tomcat, or MySQL.

### Prerequisites
* Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### How to Run
1. Clone the project and open a terminal in the root directory.
2. Run:
   ```bash
   docker compose up --build
   ```
3. Open your browser and navigate to `http://localhost:8080`.

---

## 💻 Local Setup (Eclipse IDE)

If you prefer building and running directly in your IDE:

### 1. Import Project
1. Open Eclipse IDE (Enterprise Edition).
2. Go to **File → Import...**
3. Select **General → Existing Projects into Workspace** and select this directory.

### 2. Configure Build Path & JRE
1. Right-click the project → **Build Path → Configure Build Path...**
2. Ensure **JavaSE-17** is checked under JRE libraries.
3. Ensure **Apache Tomcat 10.1+** runtime is added under Target Runtimes.

### 3. Server Configuration
1. Under the **Servers** tab, add **Apache Tomcat 10.1+**.
2. Add `Karthik_project` to the server resource list.
3. Click **Start** to run the application on `http://localhost:8080/Karthik_project`.

---

## ⚙️ Database Setup

If running locally without Docker, import the database schema to your local MySQL server:

1. Connect to your local MySQL instance.
2. Create a database:
   ```sql
   CREATE DATABASE tapyfood_db;
   ```
3. Import the file `tapyfood.sql` into it:
   ```bash
   mysql -u root -p tapyfood_db < tapyfood.sql
   ```
4. Adjust the credentials in `src/com/tapyfood/util/DBConnection.java` or expose environment variables:
   * `DB_HOST` (defaults to `localhost`)
   * `DB_USER` (defaults to `root`)
   * `DB_PASS` (defaults to your local password)

---

## 🗂️ Project Structure

```
📁 Karthik_project/
├── 📁 WebContent/
│   ├── 📁 WEB-INF/
│   │   ├── 📁 lib/            ← MySQL Connector Jar
│   │   └── 📄 web.xml         ← Deployment Descriptor
│   ├── 📁 css/                ← style.css & pages.css
│   ├── 📁 js/                 ← main.js & menu.js
│   └── 📄 *.jsp               ← UI Templates
├── 📁 src/
│   └── 📁 com/tapyfood/
│       ├── 📁 dao/            ← Data Access Objects
│       ├── 📁 model/          ← Java Beans
│       ├── 📁 servlet/        ← Servlets handling MVC controller flow
│       └── 📁 util/           ← Database connection utilities
├── 📄 Dockerfile              ← Application container configuration
├── 📄 docker-compose.yml      ← Multi-container startup configuration
└── 📄 tapyfood.sql            ← Database schema dump
```
