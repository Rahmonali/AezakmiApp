//
//  CircularProfileImageView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimention: CGFloat {
        switch self {
            case .xxSmall:
                return 28
            case .xSmall:
                return 32
            case .small:
                return 40
            case .medium:
                return 48
            case .large:
                return 64
            case .xLarge:
                return 80
        }
    }
}

struct CircularProfileImageView: View {
    let imageUrl: String?
    let size: ProfileImageSize
    
    var body: some View {
        
        if let imageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimention, height: size.dimention)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: size.dimention, height: size.dimention)
                .foregroundStyle(Color(.systemGray5))
        }
    }
}

#Preview {
    CircularProfileImageView(imageUrl: nil, size: .medium)
}
