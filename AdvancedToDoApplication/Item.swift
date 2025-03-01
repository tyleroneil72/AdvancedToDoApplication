//
//  Item.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
