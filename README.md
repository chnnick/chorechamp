# ChoreChamp  

### Overview  
ChoreChamp is an iOS app for trading, managing, and completing chores collaboratively. Built with **SwiftUI** and **Supabase**, it offers a secure, user-friendly platform for organizing responsibilities.  

---

### Features  
1. **User Authentication**  
   - Sign up, sign in, and log out securely with **Supabase Auth**.  
   - Persistent session handling for authenticated users.  

2. **Task Management**  
   - Create, update, and delete tasks with attributes like due date, completion status, and tradability.  
   - Real-time task updates stored in a **Supabase** database.  

3. **User Profiles**  
   - Fetch and display user-specific tasks and profile data.  

---

### Tech Stack  
- **Frontend:** Swift, SwiftUI  
- **Backend:** Supabase (Auth, Database) 

---

### How to Use  
1. **Authenticate:** Sign up or sign in with your email and password.  
2. **Manage Tasks:** Create, edit, or delete tasks. Mark tasks as tradable for swaps.  
3. **Sign Out:** Log out securely to end your session.  

---

### Installation  
1. Clone the repository in XCode:  
   ```bash
   git clone https://github.com/username/chorechamp.git
   ```
2. Update Secrets.swift with your supabase URL and API KEY
