//
//  ViewModel.swift
//  ChoreChamp
//
//  Created by Nick Chen on 11/3/24.
//

import Foundation
import Supabase

enum Table {
    static let tasks = "Tasks"
    static let users = "Users"
}

enum AuthAction: String, CaseIterable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var authAction: AuthAction = .signUp
    
    @Published var tasks = [TaskItem]()
    @Published var user: User? = nil
    
    @Published var showingAuthView = false
    @Published var email = ""
    @Published var password = ""
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL, supabaseKey: Secrets.apiKey)

    // MARK: - Database Manipulation
    
    // TODO: add functionality to make tradable true/false and custom task Id, MAYBE(description). ALSO add date() functionality.
    func createTaskRequest(name: String) async throws {
        let user = try await supabase.auth.session.user
        
        let task = TaskItem(id: 1, taskName: name, createdAt: "hi", completed: false, dueDate: "hi", userId: user.id, tradable: true)
        
        try await supabase
            .from(Table.tasks)
            .insert(task)
            .execute()
    }
    
    func fetchTaskRequests() async throws {
        do {
            let tasks: [TaskItem] = try await supabase
                .from(Table.tasks)
                .select()
                .eq("user_id", value: supabase.auth.session.user.id)
                .order("due_date", ascending: true)
                .execute()
                .value
            DispatchQueue.main.async {
                self.tasks = tasks
            }
        } catch {
            print("error getting task data: \(error).")
        }
    }
    
    // Get the info about the user.
    func fetchUserInfoRequests() async throws {
        do {
            let currentUser = try await supabase.auth.session.user

            let user: User = try await supabase
              .from("profiles")
              .select()
              .eq("id", value: currentUser.id)
              .single() // Fetches a single record, assuming only one user with this id exists
              .execute()
              .value
            DispatchQueue.main.async {
                self.user = user
            }
        } catch {
            print("error getting user data: \(error).")
        }
    }
    
    func updateTask(_ task: TaskItem, with name: String) async {
        guard let id = task.id else {
            print("Cannot update this task \(task.id)")
            return
        }
        
        var toUpdate = task
        toUpdate.taskName = name
        
        do {
            try await supabase
                .from(Table.tasks)
                .update(toUpdate)
                .eq("task_id", value: id)
                .execute()
        } catch {
            print("Error: \(error)")
        }
    }
    
    // function for updating profile's displayName of a User.
//    func updateProfileName(_ user: User, with name: String) async {
//        guard let id = user.id else {
//            print("Cannot update this task \(user.id)")
//            return
//        }
//        
//        var toUpdate = task
//        toUpdate.displayName = name
//        
//        do {
//            try await supabase
//                .from(Table.users)
//                .update(toUpdate)
//                .eq("id", value: supabase.auth.currentUser.id)
//                .execute()
//        } catch {
//            print("Error: \(error)")
//        }
//    }
    
    func deleteTask(at id: Int) async throws {
        try await supabase
            .from(Table.tasks)
            .delete()
            .eq("task_id", value: id)
            .execute()
    }
    
    // MARK: - Authentication
    func signUp() async throws {
        // Check if email or password is empty
        guard !email.isEmpty else {
            print("Cannot sign up with empty email!")
            return
        }
        
        guard !password.isEmpty else {
            print("Cannot sign up with empty password!")
            return
        }
        
        // Proceed with sign-up
        let _ = try await supabase.auth.signUp(email: email, password: password)
    }
    
    func signIn() async throws {
        // Check if email or password is empty
        guard !email.isEmpty else {
            print("Cannot sign in with empty email!")
            return
        }
        
        guard !password.isEmpty else {
            print("Cannot sign in with empty password!")
            return
        }
        
        let _ = try await supabase.auth.signIn(email: email, password: password)
    }
    
    func isUserAuthenticated() async {
        do {
            _ = try await supabase.auth.session.user
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
        isAuthenticated = false
    }
    
    func authorize() async throws {
        switch authAction {
        case .signUp:
            try await signUp()
        case .signIn:
            try await signIn()
        }
    }
}
