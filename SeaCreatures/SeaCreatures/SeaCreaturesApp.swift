//
//  SeaCreaturesApp.swift
//  SeaCreatures
//
//  Created by William MacDonald on 12/17/24.
//

import SwiftUI

@main
struct SeaCreaturesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 0.75, height: 0.5, depth: 0.5, in: .meters)
        
        // ID is a string that identifies the window group; each one must be unique in your project
        // String.self tells you the type of the $modelName binding (String)
        WindowGroup(id: "creatureWindow", for: String.self) { $modelName in
            SeaCreatureDetailView(modelName: modelName ?? "ToyBiplane")
                .padding3D(.all, 250)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters) // .defaultSize modifier sets the size of the volumetric window in physical units — in this case, a half-meter cube
    }
}
