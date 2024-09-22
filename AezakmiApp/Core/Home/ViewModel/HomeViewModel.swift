//
//  HomeViewModel.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI
import PencilKit

class HomeViewModel: ObservableObject {
    @Published var isSelectedPencil = false
    @Published var selectedImageCamera = false
    @Published var selectedImagePhotoLibrary = false
    
    @Published var image: Image?
    @Published var imageSelected: UIImage?
    @Published var canvasView = PKCanvasView()
    @Published var selectedPencilColor: Color = .black
    
    @Published var scale: CGFloat = 1.0
    @Published var lastScale: CGFloat = 1.0
    
    let minScale: CGFloat = 1.0
    let maxScale: CGFloat = 5.0
    
    @Published var filterIntensity = 0.5
    @Published var filterRadius = 5.0
    @Published var filterScale = 5.0
    @Published var processedImage: UIImage?
    
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @Published var showingFilterSheet = false
    @Published var showingSaveError = false
    @Published var showingSaveSuccess = false
    
    func loadImage() {
        guard let inputImage = imageSelected else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    func save() {
        // Get the drawing image
        let drawingImage = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        
        // Check if there is a processed image
        guard let processedImage = processedImage else { return }
        
        // Merge the processed image with the drawing
        guard let finalImage = mergeImages(background: processedImage, overlay: drawingImage) else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success")
            self.showingSaveSuccess.toggle()
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
            self.showingSaveError.toggle()
        }
        
        imageSaver.writeToPhotoAlbum(image: finalImage)
        
        
    }
    
    func resetFilters() {
        self.image = nil
        self.imageSelected = nil
        self.isSelectedPencil = false
    }
    
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            self.currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            self.currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            self.currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            self.image = Image(uiImage: uiImage)
            self.processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        self.currentFilter = filter
        self.loadImage()
    }
    
    func mergeImages(background: UIImage, overlay: UIImage) -> UIImage? {
        let size = background.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        background.draw(in: CGRect(origin: .zero, size: size))
        overlay.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1.0)
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return mergedImage
    }
}
