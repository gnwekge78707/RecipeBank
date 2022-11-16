//
//  ImageSelector.swift
//  Recipe-Builder
//
//  Created by Jiarui.
//

import SwiftUI

struct ImageSelector: UIViewControllerRepresentable {
    var processImage: (UIImage?) -> Void
    
    static var available: Bool {
        UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(processImage)
    }
    
    // This method called on instantiation
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        controller.delegate = context.coordinator
        return controller
    }
    
    // PhotoLibrary UI never changes
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    internal class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var processImage: (UIImage?) -> Void

        init(_ processImage: @escaping (UIImage?) -> Void) {
            self.processImage = processImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // use original image if there is no edited image
            processImage((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }
}
