//
//  Label.swift
//  LabelMaker
//
//  Created by William MacDonald on 12/17/24.
//

import Foundation
import SwiftUI


struct Label: Hashable, Codable {
    var id = UUID()
    var text = ""
    var cornerRadius = 20.0
    var colorIndex = 0 // Since Color isn’t Codable, you’re using the index – an Int – rather than the color itself; Codable conformance requires that all the properties of the struct be themselves Codable
    
    static let colors: [Color] = [.cyan, .green, .indigo]
    
    func selectedColor() -> Color {
        Label.colors[colorIndex]
    }
}
