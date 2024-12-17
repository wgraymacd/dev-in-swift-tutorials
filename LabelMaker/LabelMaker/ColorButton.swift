//
//  ColorButton.swift
//  LabelMaker
//
//  Created by William MacDonald on 12/17/24.
//

import SwiftUI

struct ColorButton: View {
    @State var color: Color // not private since accessing in preview
    var selectColor: () -> Void // closure property that returns nothing

    var body: some View {
        Button {
            selectColor()
        } label: {
            Circle()
                .foregroundStyle(color)
                .frame(height: 34)
        }
        .buttonBorderShape(.circle)
    }
}

#Preview {
    ColorButton(color: .cyan) { // have a closure here since we have a closure property above
        
    }
}
