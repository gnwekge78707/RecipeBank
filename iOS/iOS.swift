//
//  iOS.swift
//  Recipe-Builder (macOS)
//

import SwiftUI

extension UIImage {
    var imageData: Data? {
        self.jpegData(compressionQuality: 1.0)
    }
}

extension View {
    // Not needed on iOS, but is on macOS
    func macOSPadding(_ amount: CGFloat? = nil) -> some View {
        self
    }
    
    // To add navigation view only when on iOS
    func iOSNavigationView() -> some View {
        NavigationView {
            self
        }
    }
    
    // Returns a sheet on iOS, but a popover on macOS
    func nativePullout<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        self.sheet(isPresented: isPresented) {
            content()
        }
    }
}

extension Button {
    func plainButtonStyleMacOS() -> some View {
        self
    }
}
