//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by William MacDonald on 12/11/24.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self) // connect SwiftUI and SwiftData
        }
    }
}
