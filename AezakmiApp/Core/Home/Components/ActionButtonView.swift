//
//  ActionButtonView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI

struct ActionButtonView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            CustomButton(action: { homeVM.selectedImageCamera = true },
                         image: "camera",
                         foregroundColor: .pink,
                         isDisabled: false)
            
            CustomButton(action: { homeVM.selectedImagePhotoLibrary = true },
                         image: "photo",
                         foregroundColor: .pink,
                         isDisabled: false)
            
            CustomButton(action: { homeVM.isSelectedPencil.toggle() },
                         image: "pencil.and.scribble",
                         foregroundColor: homeVM.isSelectedPencil ? .black : .pink,
                         isDisabled: homeVM.imageSelected == nil)
            
            CustomButton(action: { homeVM.showingFilterSheet = true },
                         image: "slider.horizontal.3",
                         foregroundColor: .pink,
                         isDisabled: homeVM.imageSelected == nil)
            
            Spacer()
            
            CustomButton(action: { homeVM.resetFilters() },
                         image: "xmark.square",
                         foregroundColor: .pink,
                         isDisabled: homeVM.imageSelected == nil)
        }
        .tint(Color(.systemPink))
    }
}

#Preview {
    ActionButtonView()
        .environmentObject(HomeViewModel())
}
