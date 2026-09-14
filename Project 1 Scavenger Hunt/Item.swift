//
//  Item.swift
//  Project 1 Scavenger Hunt
//
//  Created by user301984 on 9/13/26.
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
