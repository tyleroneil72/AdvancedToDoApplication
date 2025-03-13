//
//  CreateCategoryModal.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI
import SwiftData

struct CreateCategoryModal: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var categoryName = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("Category Name", text: $categoryName)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Add Category") {
                let newCategory = Category(name: categoryName)
                modelContext.insert(newCategory)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(categoryName.isEmpty)
        }
        .padding()
    }
}

#Preview {
    CreateCategoryModal()
}
