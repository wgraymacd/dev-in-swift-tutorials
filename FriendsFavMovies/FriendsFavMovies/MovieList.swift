//
//  MovieList.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/11/24.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie] // removed the (sort: \Movie.title) since sort implemented in init
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    init(titleFilter: String = "") { // default value avoids fixing already written calls
        // use predicates to describe conditions for SwiftData to filter data
        // a Query applies its predicate to each of the items in the data store
        // returning true from a predicate indicates that you want to see the item
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter) // localizedStandardContains() method searches for one string inside another, while ignoring case and correctly handling international text features like accented characters
        }
        
        // property created by @Query behind the scenes, must access directly if making a custom query
        _movies = Query(filter: predicate, sort: \Movie.title)
        // @State, @Bindable, and @Environment work in a similar way to @Query, creating hidden properties prefixed with an underscore
        // These properties attach your view to the engine that powers SwiftUI
        // For example, the hidden logic in a @State property automatically updates a view whenever the property’s value changes
    }
    
    var body: some View {
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(movie.title) {
                            MovieDetail(movie: movie)
                        }
                    }
                    .onDelete { indexSet in
                        deleteMovies(indexes: indexSet)
                    }
                }
            } else {
                ContentUnavailableView("Add Movies", systemImage: "film.stack")
            }
        }
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem {
                Button("Add movie", systemImage: "plus", action: addMovie)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton() // puts view in edit mode - displays delete button next to each list item since I have the .onDelete
            }
        }
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack {
        MovieList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        MovieList(titleFilter: "tr")
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        MovieList()
            .modelContainer(for: Movie.self, inMemory: true)
    }
}

