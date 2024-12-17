//
//  LabelView.swift
//  LabelMaker
//
//  Created by William MacDonald on 12/17/24.
//

import SwiftUI

struct LabelView: View {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var label: Label // binding gives LabelView access to state passed in from a higher view
    
    var body: some View {
        TextField("Type to enter text", text: $label.text, axis: .vertical) // axis param sets scrolling direction for when text doesn't fit in available TextField space, defaults to horizontal
            .frame(width: 500, height: isEnabled ? 500 : nil)
            .padding(50)
            .background(label.selectedColor(), in: RoundedRectangle(cornerRadius: label.cornerRadius))
            .foregroundStyle(.black)
            .font(.system(size: 40, weight: .semibold))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    @Previewable @State var label = Label(text: "The label's text content")
 // local @State variable in a #Preview, you mark it @Previewable, view can then use the state variable to handle user input and update the view within the preview
    LabelView(label: $label)
        .disabled(true)
}
