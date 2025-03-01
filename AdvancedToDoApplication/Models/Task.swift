//
//  Task.swift
//  AdvnacedToDoApplication
//
//  Created by Cheuk Man Sit on 2025-02-27.
//

import Foundation
import SwiftData

@Model
final class Task {
    var title: String
    var dueDate: Date
    var category: String
    var isCompleted: Bool

    init(title: String, dueDate: Date, category: String, isCompleted: Bool = false) {
        self.title = title
        self.dueDate = dueDate
        self.category = category
        self.isCompleted = isCompleted
    }
}
