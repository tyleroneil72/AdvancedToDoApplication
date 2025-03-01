//
//  TaskViewDetail.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var task: Task

    @State private var isUpdating = false
    @State private var isDeleting = false

    var body: some View {
        VStack {
            Text(task.title)
                .font(.largeTitle)
                .padding()

            Text("Due Date: \(task.dueDate, format: .dateTime)")
                .foregroundColor(.gray)

            Toggle("Completed", isOn: Binding(
                get: { task.isCompleted },
                set: { task.isCompleted = $0 }
            ))
            .padding()

            Spacer()

            HStack {
                Button("Edit Task") {
                    isUpdating = true
                }
                .buttonStyle(.borderedProminent)

                Button("Delete") {
                    isDeleting = true
                }
                .foregroundColor(.red)
            }
        }
        .padding()
        .sheet(isPresented: $isUpdating) {
            UpdateTaskView(task: task)
        }
        .sheet(isPresented: $isDeleting) {
            DeleteTaskModal(task: task)
        }
    }
}

#Preview {
    TaskDetailView(task: Task(title: "Sample Task", dueDate: Date(), category: "Work"))
}
