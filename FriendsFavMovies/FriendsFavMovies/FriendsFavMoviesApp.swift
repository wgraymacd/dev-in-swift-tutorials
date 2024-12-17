//
//  FriendsFavMoviesApp.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/11/24.
//

import SwiftUI

@main
struct FriendsFavMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Friend.self, Movie.self])
        // variant of .modelContainer that sets up a complete SwiftData environment for you based on the model types you supply
        // won’t see any data the first time you launch the app; the SampleData model context is only linked to the previews
        // don’t have to import SwiftData to use the .modelContainer modifier
    }
}
