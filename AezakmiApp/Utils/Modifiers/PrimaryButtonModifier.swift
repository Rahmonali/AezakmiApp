//
//  PrimaryButtonModifier.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 360, height: 44)
            .background(Color(.systemPink))
            .clipShape(.rect(cornerRadius: 8))
    }
}

