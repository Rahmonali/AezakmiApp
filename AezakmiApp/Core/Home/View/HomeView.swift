//
//  HomeView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI

import CoreImage
import CoreImage.CIFilterBuiltins


struct HomeView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack {
                    if homeVM.image == nil {
                        roundedRectanglePlaceholder
                    } else {
                        selectedImageView
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                
                if homeVM.imageSelected != nil {
                    FilterControlsView()
                }
                
                ActionButtonView()
                
                Spacer()
            }
            .padding(.horizontal)
            .onChange(of: homeVM.imageSelected) { _ in homeVM.loadImage()}
            .sheet(isPresented: $homeVM.selectedImageCamera) {
                ImagePicker(selectedImage: $homeVM.imageSelected,canvasView: $homeVM.canvasView, sourceType: .camera)
            }
            .sheet(isPresented: $homeVM.selectedImagePhotoLibrary) {
                ImagePicker(selectedImage: $homeVM.imageSelected,canvasView: $homeVM.canvasView, sourceType: .photoLibrary)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if homeVM.isSelectedPencil {
                        ColorPicker("Select Color", selection: $homeVM.selectedPencilColor)
                            .labelsHidden()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: homeVM.save)
                        .disabled(homeVM.imageSelected == nil)
                }
            }
            .confirmationDialog("Select a filter", isPresented: $homeVM.showingFilterSheet) {
                ConfirmationDialogFilterButtons()
            }
            .alert("Oops!", isPresented: $homeVM.showingSaveError) {
                Button("OK") { homeVM.showingSaveError.toggle() }
            } message: {
                Text("Sorry, there was an error saving your image - please check that you have allowed permission for this app to save photos")
            }
            .alert("Success", isPresented: $homeVM.showingSaveSuccess) {
                Button("OK") {
                    homeVM.showingSaveSuccess.toggle()
                    homeVM.resetFilters()
                }
            } message: {
                Text("Image saved to the gallery")
            }
        }
    }
}

extension HomeView {
    private var roundedRectanglePlaceholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemGray2))
            
            Text("Please select an image")
                .foregroundColor(Color(.white))
                .font(.headline)
        }
    }
    
    private var selectedImageView: some View {
        homeVM.image?
            .resizable()
            .scaledToFit()
            .scaleEffect(homeVM.scale)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                CanvasView(
                    canvasView: $homeVM.canvasView,
                    isSelectedPencil: $homeVM.isSelectedPencil,
                    pencilColor: homeVM.selectedPencilColor
                )
                .background(Color.clear)
            }
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let newScale = homeVM.lastScale * value
                        homeVM.scale = min(max(newScale, homeVM.minScale), homeVM.maxScale)
                    }
                    .onEnded { value in
                        homeVM.lastScale = homeVM.scale
                    }
            )
    }
}

#Preview {
    HomeView()
}
