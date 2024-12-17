//
//  SubmitButton.swift
//  Alphabetizer
//
//
//

import SwiftUI

struct SubmitButton: View {
    @Environment(Alphabetizer.self) private var alphabetizer

    var body: some View {
        Button {
            alphabetizer.submit()
        } label: {
            Image(systemName: "play.circle")
                .font(.system(size: 60))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 80)
                .padding(.vertical, 20)
                .background(RoundedRectangle(cornerRadius: 30)
                    .fill(Color.purple)
                    .opacity(isEnabled ? 1.0 : 0.5)
                )
        }
        .animation(.default, value: isEnabled)
        .disabled(!isEnabled)
    }
    
    // Because Task runs asynchronously, submit needs to either handle concurrent tasks or prevent them from occurring in the first place (Alphabetizer chooses the latter)
    var isEnabled: Bool {
        // benefit of using enum - easier to check for a named enum case than to check the contents of a string or to introduce another variable when you need to know the game’s state
        alphabetizer.message == .instructions
    }
}

#Preview {
    SubmitButton()
        .environment(Alphabetizer())
}
