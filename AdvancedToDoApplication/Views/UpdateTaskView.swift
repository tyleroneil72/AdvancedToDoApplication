//
//  UpdateTaskView.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI

struct UpdateTaskView: View {
    @Environment(\.dismiss) private var dismiss
    var task: Task

    @State private var title: String
    @State private var dueDate: Date
    @State private var category: String

    init(task: Task) {
        self.task = task
        _title = State(initialValue: task.title)
        _dueDate = State(initialValue: task.dueDate)
        _category = State(initialValue: task.category)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Task Title", text: $title)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    TextField("Category", text: $category)
                }

                Section {
                    Button("Update Task") {
                        updateTask()
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty)
                }

            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private func updateTask() {
        task.title = title
        task.dueDate = dueDate
        task.category = category
    }
}

#Preview {
    UpdateTaskView(task: Task(title: "Sample Task", dueDate: Date(), category: "Personal"))
}
