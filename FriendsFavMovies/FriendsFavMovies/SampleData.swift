//
//  SampleData.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/11/24.
//

import Foundation
import SwiftData

// build model container explicitly instead of using the .modelContainer modifier
// this way, can create and manage your sample data in one place
// use the same model container in all your previews
@MainActor // all code in this class must run on the main actor, including access to the mainContext property, fixes context var error
class SampleData {
    static let shared = SampleData() // static keyword defines the shared property as belonging to the class itself, not each individual instance
    
    let modelContainer: ModelContainer
    
    // to make other code more concise
    var context: ModelContext {
        modelContainer.mainContext // error saying that you should access the mainContext property from the main actor, Swift uses actors to manage code that runs concurrently
    }
    
    // used in FriendDetail preview
    var friend: Friend {
        Friend.sampleData.first! // forced unwrap operator, unwraps optional but terminates program if value not present
    }
    
    // used in MovieDetail preview
    var movie: Movie {
        Movie.sampleData.first!
    }
    
    // private so that instances of SampleData can only be created from within the SampleData class itself
    // in this case, the single shared instance is the only one you create, which ensures that shared is the only instance of SampleData - common way to create globally shared objects
    private init() {
        // schema of a model helps connect the classes defined in code to the data in the data store
        let schema = Schema([Friend.self, Movie.self])
        
        // model configuration, passing your schema and specifying that it should store data in memory without persisting it (shouldn't use persisted data for your previews)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        // this might throw an error if it doesn't work, so we have to handle it
        // use `try` keyword to tell the compiler you are going to attempt making the call and see if it works
        // must wrap everything in a do/catch clause
        // the code in the catch block guarantees that the init will always set the value of modelContainer
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData() // `try` not required since it can't fail
            
            try context.save()
        } catch { // executed only if code in `do` throws error
            fatalError("Could not create ModelContainer: \(error)") // fatalError often used to find and fix coding mistakes that should never appear in a finished app
        }
        
    }
    
    private func insertSampleData() {
        for friend in Friend.sampleData {
            context.insert(friend) // model context tracks the sample friends for changes
        }
        for movie in Movie.sampleData {
            context.insert(movie) // model context tracks the sample friends for changes
        }
        
        // create relationships after inserting all models into the context
        // When you set the value of a property at one end of a relationship (favoriteMovie), SwiftData automatically updates the corresponding property on the other end (favoritedBy) for you
        Friend.sampleData[0].favoriteMovie = Movie.sampleData[1]
        Friend.sampleData[2].favoriteMovie = Movie.sampleData[0]
        Friend.sampleData[3].favoriteMovie = Movie.sampleData[4]
        Friend.sampleData[4].favoriteMovie = Movie.sampleData[0]
    }
}
