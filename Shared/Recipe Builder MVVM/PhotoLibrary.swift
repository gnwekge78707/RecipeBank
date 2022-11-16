//
//  ImageSelector.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 15/07/2021.
//

import SwiftUI

struct ImageSelector: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageSelector>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
    
    internal class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    }
}
