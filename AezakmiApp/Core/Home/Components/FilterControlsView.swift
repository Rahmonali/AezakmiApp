//
//  FilterControlsView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI

struct FilterControlsView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            if homeVM.currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                HStack {
                    Text("Intensity")
                    Slider(value: $homeVM.filterIntensity)
                        .onChange(of: homeVM.filterIntensity) { _ in homeVM.applyProcessing() }
                }
                .padding(.vertical)
            }
            
            if homeVM.currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                HStack {
                    Text("Radius")
                    Slider(value: $homeVM.filterRadius, in: 0...200)
                        .onChange(of: homeVM.filterRadius) { _ in homeVM.applyProcessing() }
                }
                .padding(.vertical)
            }
            
            if homeVM.currentFilter.inputKeys.contains(kCIInputScaleKey) {
                HStack {
                    Text("Sacle")
                    Slider(value: $homeVM.filterScale, in: 0...10)
                        .onChange(of: homeVM.filterScale) { _ in homeVM.applyProcessing() }
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    FilterControlsView()
        .environmentObject(HomeViewModel())
}
