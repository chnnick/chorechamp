//
//  ContentView.swift
//  NickChoreChamp
//
//  Created by Nick Chen on 11/2/24.
//

import SwiftUI
import Supabase

struct ContentView: View {
    
    @State private var isAuthenticated = false
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL, supabaseKey: Secrets.apiKey)
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                TasksListView();
            }
            else {
                AuthView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}

