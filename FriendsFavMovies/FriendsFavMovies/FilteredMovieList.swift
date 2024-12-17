//
//  FilteredMovieList.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/12/24.
//

// Though it may feel odd to have a FilteredMovieList view that just contains a search field and a MovieList view, that’s exactly the pattern that you should follow, creating small, single-purpose views

import SwiftUI

struct FilteredMovieList: View {
    @State private var searchText = ""

    var body: some View {
        NavigationSplitView {
            MovieList(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
