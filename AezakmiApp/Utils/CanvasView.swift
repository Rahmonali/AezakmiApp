//
//  CanvasView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 22/09/24.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @Binding var isSelectedPencil: Bool
    var pencilColor: Color
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: UIColor(pencilColor), width: 5)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if isSelectedPencil {
            uiView.isUserInteractionEnabled = true
            uiView.tool = PKInkingTool(.pen, color: UIColor(pencilColor), width: 5)
        } else {
            uiView.isUserInteractionEnabled = false
            uiView.tool = PKInkingTool(.pencil, color: .clear, width: 0)
        }
        
        uiView.backgroundColor = .clear
    }
}

