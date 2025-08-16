//
//  Item.swift
//  SwiftTemplate
//
//  Created by Kamiyama Yoshihito on 2025/08/16.
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
