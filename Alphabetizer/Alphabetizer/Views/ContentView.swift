//
//  ContentView.swift
//  Alphabetizer
//
//
//

import SwiftUI

struct ContentView: View {
    // could have @State variable on ContentView that is passed down to the child views through initializers
    // distributing Alphabetizer through the environment has the benefit of disconnecting the views
    
    var body: some View {
        VStack(spacing: 20) {
            ScoreView()
            MessageView()
            Spacer()
            WordCanvas()
            Spacer()
            SubmitButton()
        }
        .padding(.top, 50)
    }
}

#Preview {
    ContentView()
        .environment(Alphabetizer()) // Even though ContentView doesn’t access the Alphabetizer directly, all the child views inherit the environment variables from their parent
}
