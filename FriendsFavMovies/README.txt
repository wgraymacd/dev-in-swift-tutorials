tutorial order: 4, 5, 6
tutorial at:
4: https://developer.apple.com/tutorials/develop-in-swift/navigate-sample-data
5: https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
6: https://developer.apple.com/tutorials/develop-in-swift/work-with-relationships


Part 4:

Reflect on the concepts:
Sample data
As you developed your views in earlier tutorials, you hardcoded their data — either by passing string literals directly into Text views or by setting the initial values of their @State properties. That is fine for prototyping simple views, but @Query properties don’t let you directly set initial hardcoded arrays of values.
In this app, you created a class to configure a ModelContainer that stores sample data without persisting it. Then you passed the model container into all your previews, connecting it to the queries and the modelContext value from the environment. This let you develop views using the same set of sample data without needing to add specialized code to your views to manage it.
Navigation
Friends’ Favorite Movies is your first app featuring navigation through a hierarchy of content. This is a common pattern in many apps. There’s a limit to how much useful information can be packed into one screen, and navigation is an important way to help people tackle one thing at a time.
NavigationSplitView is one of a set of powerful SwiftUI views you can use to manage an information hierarchy. Combine it with NavigationLink to let people explore the content of your app and understand how it’s organized.

Topics and skills covered:
Defining sample data and reusing it across SwiftUI previews as a shared instance
Manually creating Schema, ModelConfiguration, and ModelContainer
Displaying structured data in navigation hierarchies using NavigationSplitView, NavigationStack, and NavigationLink

Part 5:

Reflect on the concepts:
Modal content
You learned how to present short, specific tasks in modal interfaces to create new friends and movies using the .sheet modifier. Modal presentation is another form of navigation, and it’s essential for keeping people focused as they use your app.
Component views
You used the FriendDetail and MovieDetail views for both creating new items and editing existing ones. Reusable and flexible components are fundamental building blocks for assembling more complex applications. Focused views break a large app into smaller bits that are significantly easier to understand, just like model types make data easier to understand. Your views and models work together: Models provide data, and views display that data and modify it in response to input.

Topics and skills covered:
Reusable detail views for both creating and editing data
Modifying data models with @Bindable
The Form container view
Displaying modal interfaces using sheets
Optionals
Custom view initializers

Part 6:

Reflect on the concepts:
Relationships
Instead of a favorite movie, what if your app tracked all the movies your friends have watched? Many friends will watch the same movie, and movies might have been seen by many friends.
With that new relationship, you could build a list of the most watched movies. Or you could build a watch party feature to recommend a movie that none of the attendees has seen before. Your app’s functionality is determined not only by the data in the model types you create but also by the relationships among those types.
Dynamic queries
SwiftData is powered by a relational database engine that efficiently stores and retrieves your models. It also gives you powerful queries to filter the retrieved data and sort it for display.
You can provide SwiftData filtering and sorting criteria when declaring a @Query property. But often you’ll want to give people a way to choose how they want to see the data in your app — for example, sorting items alphabetically or by date.
To create a dynamic query, you take advantage of a key SwiftUI power: creating small, single-purpose views. Though it may feel odd to have a FilteredMovieList view that just contains a search field and a MovieList view, that’s exactly the pattern that you should follow.
The key is providing a custom view initializer, which lets you initialize the query property wrapper with values passed in from the parent view.

Topics and skills covered:
Relating one model to another using properties
Making a many-to-one relationship with an optional model type
Making a one-to-many relationship with an array of model types
Using a Picker to choose a value from a list of options
Predicates that use logical expressions to filter data
Initializing a custom @Query property wrapper
Using a wrapper view to enable dynamic updates of query criteria
Rendering views conditionally using Group
Using ContentUnavailableView when there’s nothing to display