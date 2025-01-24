//
//  UpdateView.swift
//  ChoreChamp
//
//  Created by Nick Chen on 11/3/24.
//

import SwiftUI

struct UpdateView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    let task: TaskItem
    
    @State private var name = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Task Description", text: $name, axis: .vertical)
        }
        .onAppear {
            name = task.taskName
        }
        Button {
            Task {
                await viewModel.updateTask(task, with: name)
                dismiss()
            }
        } label: {
            Text("Update")
        }
    }
}
