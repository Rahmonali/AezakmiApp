//
//  CustomButton.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let image: String
    let foregroundColor: Color
    let isDisabled: Bool

    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .font(.title2)
                .foregroundStyle(foregroundColor)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
    }
}

#Preview {
    CustomButton(action: {}, image: "person", foregroundColor: .pink, isDisabled: false)
}
