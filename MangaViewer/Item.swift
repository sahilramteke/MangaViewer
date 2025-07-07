//
//  Item.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
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
