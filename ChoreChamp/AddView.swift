//
//  AddView.swift
//  ChoreChamp
//
//  Created by Nick Chen on 11/3/24.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var text = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Chore Description", text: $text)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    Task {
                        try await viewModel.createTaskRequest(name: text)
                        dismiss()
                    }
                } label: {
                    Text("Add")
                }
            }
        }
    }
}
