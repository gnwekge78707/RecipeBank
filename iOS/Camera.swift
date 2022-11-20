//
//  Camera.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm.
//

import SwiftUI

struct Camera: UIViewControllerRepresentable {
    var processImage: (UIImage?) -> Void
    
    static var available: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(processImage)
    }
    
    // This method called on instantiation
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.allowsEditing = true
        controller.delegate = context.coordinator
        return controller
    }
    
    // Camera UI never changes
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    internal class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var processImage: (UIImage?) -> Void
        
        init(_ processImage: @escaping (UIImage?) -> Void) {
            self.processImage = processImage
        }
        
        // When the user closes the camera, without taking a picture
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            processImage(nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // use original image if there is no edited image
            processImage((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }
}
