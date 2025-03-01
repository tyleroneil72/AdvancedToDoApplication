//
//  Category.swift
//  AdvnacedToDoApplication
//
//  Created by Cheuk Man Sit on 2025-02-27.
//

import Foundation
import SwiftData

@Model
final class Category {
    var name: String

    init(name: String) {
        self.name = name
    }
}
