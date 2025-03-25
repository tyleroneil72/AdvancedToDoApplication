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
    @Query private var categories: [Category]

    @State private var isAddingTask = false
    @State private var isAddingCategory = false

    var groupedTasks: [String: [Task]] {
        Dictionary(grouping: tasks, by: { $0.category })
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedTasks.keys.sorted(), id: \.self) { category in
                    Section(header: Text(category.isEmpty ? "General" : category).font(.headline)) {
                        ForEach(groupedTasks[category] ?? []) { task in
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                taskRowView(for: task)
                            }
                        }
                        .onDelete { indexSet in deleteTask(indexSet, category: category) }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { isAddingTask.toggle() } label: {
                        Label("Add Task", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button("Add Category") { isAddingCategory.toggle() }
                        NavigationLink("Manage Categories") {
                            CategoryBoardView()
                        }
                    } label: {
                        Label("Categories", systemImage: "folder")
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

    private func taskRowView(for task: Task) -> some View {
        HStack {
            Text(task.title).font(.headline)
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
            } else if task.dueDate < Date() {
                Text("Overdue").foregroundColor(.red)
            } else {
                Text(task.dueDate, style: .date).foregroundColor(.gray)
            }
        }
    }

    private func deleteTask(_ offsets: IndexSet, category: String) {
        withAnimation {
            groupedTasks[category]?.enumerated().forEach { index, task in
                if offsets.contains(index) { modelContext.delete(task) }
            }
        }
    }
}

#Preview {
    TaskBoardView()
}
