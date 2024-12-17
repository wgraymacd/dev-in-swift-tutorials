//
//  SeaCreature.swift
//  SeaCreatures
//
//  Created by William MacDonald on 12/17/24.
//

import Foundation

struct SeaCreature: Identifiable { // Identifiable helps uniquely identify instances of a type, need for array of creatures and ForEach iteration
    var name: String
    var modelName: String
    var id = UUID()
}
