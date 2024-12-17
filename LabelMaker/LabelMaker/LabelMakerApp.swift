//
//  LabelMakerApp.swift
//  LabelMaker
//
//  Created by William MacDonald on 12/17/24.
//

import SwiftUI

@main
struct LabelMakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        // This WindowGroup is now used every time openWindow contains a label
        // A WindowGroup defines a view hierarchy that the app can present, an app can have multiple WindowGroup definitions – each handling a different set of data
        WindowGroup(for: Label.self) { $label in
            LabelView(label: $label)
                .disabled(true) // can't edit labels once created
        } defaultValue: {
            Label(text: "", cornerRadius: 20)
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain) // removes default visionOS frame so label is on its own
    }
}

// to create windows in visionOS, define a WindowGroup within the App body with an id value that the @Environment can use when calling openWindow, the openWindow function uses a String ID to open the View contained within the WindowGroup with the same id value
