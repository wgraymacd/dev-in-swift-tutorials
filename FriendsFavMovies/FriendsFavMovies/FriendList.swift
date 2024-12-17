//
//  FriendList.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/11/24.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) private var friends: [Friend] // query fetches data from the model context and updates the view as it changes
    
    // in general, use an @Environment property to access important global information, like the current color scheme of the device
    @Environment(\.modelContext) private var context // to access model context
    
    @State private var newFriend: Friend? // optional type, set to nil when structure (this one, FriendList) created unless otherwise specified
    
    var body: some View {
        NavigationSplitView {
            Group { // used so that the modifiers can be applied (can't apply modifiers to an `if` block, `if` is not a view, groups do nothing
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink(friend.name) {
                                FriendDetail(friend: friend)
                            }
                        }
                        .onDelete(perform: deleteFriends(indexes:))
                    }
                } else {
                    ContentUnavailableView("Add Friends", systemImage: "person.and.person")
                }
            }
            .navigationTitle("Friends")
            .toolbar { // used to above or below main content of screen
                ToolbarItem {
                    Button("Add Friend", systemImage: "plus", action: addFriend) // just write the function name, not the ()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newFriend) { friend in // sheet triggered to appear when the optional newFriend property has a value, dismissed is value set to nil, pass a binding to allow the sheet itself to set the property to nil, which it does when people dismiss it interactively
                NavigationStack { // to show navigation bar in detail view when presented in the sheet
                    FriendDetail(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled() // can't drag sheet down to dismiss it (can't tell whether people wanna save new friend or cancel)
            }
        } detail: {
            // default detail view - view that people see when nothing is selected in the sidebar
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addFriend() {
        let newFriend = Friend(name: "") // local variable in the addFriend() method that shadows the @State property by the same name
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriends(indexes: IndexSet) {
        for index in indexes {
            context.delete(friends[index])
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer) // a query relies on a SwiftData model container to get its data
}

// to preview the ContentUnavailableView
#Preview("Empty List") {
    FriendList()
        .modelContainer(for: Friend.self, inMemory: true) // Rather than giving it your sample data model container, use the version of the modifier that creates an empty container
}

