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
        Form {
            TextField("Task Title", text: $title)
            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            TextField("Category", text: $category)

            Button("Update Task") {
                task.title = title
                task.dueDate = dueDate
                task.category = category
                dismiss()
            }
        }
        .navigationTitle("Edit Task")
    }
}

#Preview {
    UpdateTaskView(task: Task(title: "Sample", dueDate: Date(), category: "Personal"))
}
