//
//  FriendDetail.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/12/24.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
    @Bindable var friend: Friend // making this bindable lets us pass a binding to it (or its properties) into controls like TextField, works since all model classes in SwiftData are observable, allowing SwiftUI to track changes to their properties
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss // dismiss property from SwiftUI environment, this is a function, dismisses current modal presentation
    @Environment(\.modelContext) private var context // to delete friend when canceling
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    // to avoid having to init all FriendDetail views with isNew
    init(friend: Friend, isNew: Bool = false) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
            
            Picker("Favorite Movie", selection: $friend.favoriteMovie) { // Use a Picker when you want people to choose an item from a list of options
                Text("None")
                    .tag(nil as Movie?) // cast nil to type Movie?, otherwise can refer to an optional of any type
                
                ForEach(movies) { movie in
                    Text(movie.title)
                        .tag(movie) // to correctly display and assign a new value to its selection — the $friend.favoriteMovie binding — you must tag each item with a compatible value
                }
            }
        }
        .navigationTitle(isNew ? "New Friend" : "Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { // items in here displayed at top of screen iff wrapped in a navigation stack (in current view or parent view)
            if isNew { // no need for these if editing friend cuz changes applied immediately
                ToolbarItem(placement: .confirmationAction) { // by specifying the item’s placement semantically, with .confirmationAction, you let SwiftUI choose the appropriate location for it
                    Button("Save") { // to confirm adding a friend
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(friend) // When you present this view in a sheet to create a friend, the ContentView has already inserted one into the context, easiest place to remove it is here
                        dismiss()
                    }
                }
            }
        }
    }
}

// default is that isNew = false
#Preview {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend)        
    }
    .modelContainer(SampleData.shared.modelContainer)
}

// second preview, see how the detail view looks when isNew = true
#Preview("New Friend") {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
