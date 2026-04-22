# 🤝 Contributing Guide — Online Examination & Result Management System

Please read this guide carefully before contributing to the project.

---

## ✅ Step 1 — First Time Setup

### 📥 Clone the Repository

```bash
git clone https://github.com/IT25102078/Online_examination_and_result_management_system.git
cd online-exam-system
```

---

### 🔄 Switch to Develop Branch

```bash
git checkout develop
git pull origin develop
```

---

### 💻 Open in IntelliJ IDEA

1. Open IntelliJ IDEA
2. Click **File → Open**
3. Select the project folder

⏳ Wait until Maven downloads all dependencies.

---

### 🗄️ Setup Your Database

1. Open **MySQL Workbench**
2. Run:

```sql
CREATE DATABASE exam_system_db;
```

3. Open the file:

```
src/main/resources/application.properties
```

4. Update your database credentials:

```properties
spring.datasource.username=root
spring.datasource.password=your_password
```

---

### ▶️ Run the Project

Run the application from IntelliJ.

Then open your browser:

```
http://localhost:8080
```

---

## ✅ Step 2 — Daily Workflow

### 🔄 Before Coding

Always pull the latest changes:

```bash
git checkout develop
git pull origin develop
```

---

### 🌿 Create Feature Branch (Only Once)

```bash
git checkout -b feature/your-feature-name
```

---

### 💾 After Coding

Save your work:

```bash
git add .
git commit -m " Your feature description"
git push origin feature/your-feature-name
```

---

### 🔀 Create Pull Request

1. Go to **GitHub**
2. Click **Pull Requests → New Pull Request**
3. Set:

   * Base branch: `develop`
   * Compare branch: your feature branch
4. Add a clear title and description
5. Submit the Pull Request

---

## ⚠️ Important Rules

* ❌ Never push directly to `main` or `develop`
* ✅ Always use feature branches
* 🔄 Always pull latest code before coding
* 🧪 Test your code before creating a Pull Request
* 🔐 Never commit your real database password


