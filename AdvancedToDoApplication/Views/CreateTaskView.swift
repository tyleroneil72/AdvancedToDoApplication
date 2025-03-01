//
//  CreateTaskView.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI
import SwiftData

struct CreateTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var dueDate = Date()
    @State private var selectedCategory = "General"
    
    var existingCategories: [String]

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)

                Picker("Category", selection: $selectedCategory) {
                    Text("General").tag("General")
                    ForEach(existingCategories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }

                Button("Add Task") {
                    let newTask = Task(title: title, dueDate: dueDate, category: selectedCategory)
                    modelContext.insert(newTask)
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateTaskView(existingCategories: ["Work", "School"])
}
