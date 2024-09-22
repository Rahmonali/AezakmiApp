//
//  ConfirmationDialogFilterButtons.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI

struct ConfirmationDialogFilterButtons: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        Group {
            Group {
                Button("Bloom") { homeVM.setFilter(CIFilter.bloom()) }
                Button("Crystallize") { homeVM.setFilter(CIFilter.crystallize()) }
                Button("Edges") { homeVM.setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { homeVM.setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { homeVM.setFilter(CIFilter.pixellate()) }
                Button("Pointillize") { homeVM.setFilter(CIFilter.pointillize()) }
                Button("Sepia Tone") { homeVM.setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { homeVM.setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { homeVM.setFilter(CIFilter.vignette()) }
                Button("Crystallize") { homeVM.setFilter(CIFilter.crystallize()) }
            }
            Group {
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

#Preview {
    ConfirmationDialogFilterButtons()
        .environmentObject(HomeViewModel())
}
