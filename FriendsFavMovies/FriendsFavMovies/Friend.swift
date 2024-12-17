//
//  Friend.swift
//  FriendsFavMovies
//
//  Created by William MacDonald on 12/11/24.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var favoriteMovie: Movie? // a many-to-one relationship from Friend and Movie
    
    init(name: String) {
        self.name = name // self refers to the object being initialized
    }
    
    static let sampleData = [
        Friend(name: "Elena"),
        Friend(name: "Graham"),
        Friend(name: "Mayuri"),
        Friend(name: "Rich"),
        Friend(name: "Rody"),
    ]
}
