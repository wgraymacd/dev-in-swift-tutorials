//
//  ContentView.swift
//  LabelMaker
//
//  Created by William MacDonald on 12/17/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    // environment property wrapper reads a value from a view’s environment
    @Environment(\.openWindow) private var openWindow // offers functions for opening new windows
    @State private var label = Label()

    var body: some View {
        LabelView(label: $label)
            .padding(55)
            .ornament(attachmentAnchor: .scene(.bottom)) { // ornaments can contain any SwiftUI view, but they are typically used for controls and not content
                HStack(spacing: 30) {
                    Slider(value: $label.cornerRadius, in: 0...100)
                        .frame(width: 100)
                    HStack(spacing: 10) {
                        ForEach(Label.colors.indices, id: \.self) { index in
                            ColorButton(color: Label.colors[index]) {
                                label.colorIndex = index
                            }
                        }
                    }
                    Button("Create") {
                        openWindow(value: label) // The type of value determines the kind of window to open, and its contents are used to populate the new window, Label must now be Hashable, Encodable, and Decodable
                        label = Label(cornerRadius: label.cornerRadius, colorIndex: label.colorIndex) // copy label just made into new one after the old label gets passed off to openWindow
                    }
                }
                .padding([.top, .bottom], 15)
                .padding([.leading, .trailing], 38)
                .glassBackgroundEffect()
            }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
