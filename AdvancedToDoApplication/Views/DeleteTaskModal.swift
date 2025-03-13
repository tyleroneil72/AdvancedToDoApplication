//
//  DeleteTaskModal.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI

struct DeleteTaskModal: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    var task: Task

    var body: some View {
        VStack(spacing: 16) {
            Text("Are you sure you want to delete this task?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            Text(task.title)
                .font(.title3)
                .foregroundColor(.red)

            HStack {
                Button("Cancel") { dismiss() }
                    .buttonStyle(.bordered)

                Button("Delete") {
                    modelContext.delete(task)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .padding()
    }
}

#Preview {
    DeleteTaskModal(task: Task(title: "Sample Task", dueDate: Date(), category: "Work"))
}
