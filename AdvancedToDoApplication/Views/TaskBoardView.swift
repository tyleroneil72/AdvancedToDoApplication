//
//  TaskBoardView.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI
import SwiftData

struct TaskBoardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    @Query private var categories: [Category] // Fetch categories

    @State private var isAddingTask = false
    @State private var isAddingCategory = false

    var groupedTasks: [String: [Task]] {
        Dictionary(grouping: tasks) { $0.category }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedTasks.keys.sorted(), id: \.self) { category in
                    Section(header: Text(category.isEmpty ? "General" : category)
                        .font(.headline)) {
                        ForEach(groupedTasks[category] ?? []) { task in
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                HStack {
                                    Text(task.title)
                                        .font(.headline)
                                    Spacer()
                                    if task.isCompleted {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                    } else if task.dueDate < Date() {
                                        Text("Overdue")
                                            .foregroundColor(.red)
                                    } else {
                                        Text(task.dueDate, style: .date)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            deleteTask(indexSet, category: category)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingTask.toggle() }) {
                        Label("Add Task", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isAddingCategory.toggle() }) {
                        Label("Add Category", systemImage: "folder.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingTask) {
                CreateTaskView(existingCategories: categories.map { $0.name })
            }
            .sheet(isPresented: $isAddingCategory) {
                CreateCategoryModal()
            }
        }
    }

    private func deleteTask(_ offsets: IndexSet, category: String) {
        withAnimation {
            if let tasksToDelete = groupedTasks[category] {
                for index in offsets {
                    modelContext.delete(tasksToDelete[index])
                }
            }
        }
    }
}

#Preview {
    TaskBoardView()
}
