//
//  CategoryBoardView.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-03-25.
//

import SwiftUI
import SwiftData

struct CategoryBoardView: View {
    @Query private var categories: [Category]
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var editingCategory: Category?
    @State private var newName: String = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    HStack {
                        Text(category.name)
                        Spacer()
                        Button("Edit") {
                            editingCategory = category
                            newName = category.name
                        }
                        .buttonStyle(.bordered)

                        Button("Delete") {
                            deleteCategory(category)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("Manage Categories")
            .sheet(item: $editingCategory) { category in
                VStack(spacing: 20) {
                    Text("Rename Category")
                        .font(.headline)

                    TextField("New Name", text: $newName)
                        .textFieldStyle(.roundedBorder)
                        .padding()

                    HStack {
                        Button("Cancel") {
                            editingCategory = nil
                        }
                        .buttonStyle(.bordered)

                        Button("Save") {
                            renameCategory(category, to: newName)
                            editingCategory = nil
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(newName.isEmpty)
                    }
                }
                .padding()
            }
        }
    }

    private func renameCategory(_ category: Category, to newName: String) {
        let oldName = category.name
        category.name = newName

        for task in tasks where task.category == oldName {
            task.category = newName
        }
    }

    private func deleteCategory(_ category: Category) {
        for task in tasks where task.category == category.name {
            modelContext.delete(task)
        }

        // Delete the category itself
        modelContext.delete(category)
    }
}

#Preview {
    CategoryBoardView()
}
