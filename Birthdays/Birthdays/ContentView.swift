//
//  ContentView.swift
//  Birthdays
//
//  Created by William MacDonald on 12/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // all friends added
    // @Query to fetch Friend instances stored in SwiftData
    // @Wuery updates views when you update the instances of Friend stored in SwiftData like @State
    @Query(sort: \Friend.birthday) private var friends: [Friend] // sorted chronologically with the (code in parantheses)
    
    // SwiftData reqs model context to save new items
    // A ModelContext provides a connection between the view and the model container so that you can fetch, insert, and delete items in the container
    // the .modelContainer modifier you added to ContentView inserts a modelContext into the SwiftUI environment, and that modelContext is accessible to all views under the container
    @Environment(\.modelContext) private var context
    
    // adding new friend
    @State private var newName = ""
    @State private var newDate = Date.now
    
    var body: some View {
        NavigationStack { // often used to stack views on top of each other, like a stack of cards, where only top view visible at any time and stack manipulated by adding or taking views to or from top of the stack, but adds other functionality like titles, navigation bars, buttons, toolbars
            // notice that there is no id here, and that is cuz SwiftData provides one for every instance of a model type
            List(friends) { friend in
                HStack {
                    if friend.isBirthdayToday {
                        Image(systemName: "birthday.cake")
                    }
                    Text(friend.name)
                        .bold(friend.isBirthdayToday)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year()) // rendered according to device's current calendar
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) { // this modifier can anchor content to any side of the screen
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) { // in: configures so that can't select a date in the future
                        TextField("Name", text: $newName) // using label of DatePicker to display TextField since the "New Birthday" Text above describes what does into the DatePicker already
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate)
                        context.insert(newFriend) // inserting into the ModelContext saves the new Friend into the container and since @Query is also connected to the container, it will pick up and display the new Friend without you explicitly adding newFriend to friends
                        
                        newName = ""
                        newDate = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar) // style of system toolbar
            }
//            .task { // create sample data down here, not in the @Query line, .task code before the view appears
//                context.insert(Friend(name: "Elton Lin", birthday: .now))
//                context.insert(Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0)))
//            }
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true) // previews should start in same initial state every time they refresh; inMemory: true refers to the storage mechanism - data is stored only as long as the app is in memory
}
