//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by William MacDonald on 12/11/24.
//

import SwiftUI

struct SettingsView: View {
    // A @Binding connects a property to a source of truth stored elsewhere, instead of storing data directly
    @Binding var startingPoints: Int
    @Binding var doesHighestScoreWin: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Rules")
                .font(.headline)
            
            Divider()
            
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest Score Wins")
                    .tag(true)
                Text("Lowest Score Wins")
                    .tag(false)
            }
            
            Picker("Starting points", selection: $startingPoints) {
                Text("0 starting points")
                    .tag(0) // tag is what is assigned to startingPoints when picked
                Text("10 starting points")
                    .tag(10)
                Text("20 starting points")
                    .tag(20)
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
}

//#Preview {
//    @Previewable @State var doesHighestScoreWin = true
//    @Previewable @State var startingPoints = 10
//    SettingsView(doesHighestScoreWin: $doesHighestScoreWin, startingPoints: $startingPoints)
//}
