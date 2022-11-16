//
//  macOS.swift
//  Recipe-Builder (macOS)
//
//  Created by Jake Davies on 15/07/2021.
//

import SwiftUI

// UIImage not supported on macOS, but NSImage works and behaves similarly
typealias UIImage = NSImage

extension Image {
    init(uiImage: NSImage) {
        self.init(nsImage: uiImage)
    }
}

// NavigationBar not supported on macOS
extension View {
    func navigationBarItems<L, T>(leading: L, trailing: T) -> some View where L : View, T : View {
        VStack {
            HStack {
                leading
                Spacer()
                trailing
            }
            self
            Spacer()
        }
    }
    
    func navigationBarItems<T>(trailing: T) -> some View where T: View {
        VStack {
            HStack {
                Spacer()
                trailing
            }
            self
            Spacer()
        }
    }
    
    // Returns a sheet on iOS, but a popover on macOS
    func nativePullout<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        self.popover(isPresented: isPresented) {
            content()
        }
    }
    
    // Popovers look better on macOS with padding
    @ViewBuilder
    func macOSPadding(_ amount: CGFloat? = nil) -> some View {
        if amount != nil {
            self.padding(amount!)
        } else {
            self.padding()
        }
    }
    
    // macOS doesn't support .fullScreenCover()
    func fullScreenCover<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View {
        
        self.sheet(item: item, content: content)
    }
    
    // The navigation view modifier only works on iOS for these views
    func iOSNavigationView() -> some View {
        self
    }
    
    // Action sheets not supported in macOS
    func actionSheet(isPresented: Binding<Bool>, content: () -> ActionSheet) -> some View {
        self
    }
}
struct ActionSheet {}

extension Button {
    func plainButtonStyleMacOS() -> some View {
        self.buttonStyle(PlainButtonStyle())
    }
}


// Camera and ImageSelector not supported on macOS
struct Camera: View {
    static let available = false
    let processImage: (NSImage?) -> Void
    
    var body: some View {
        EmptyView()
    }
}

struct ImageSelector: View {
    static let available = false
    let processImage: (NSImage?) -> Void
    
    var body: some View {
        EmptyView()
    }
}

extension UIImage {
    var imageData: Data? {
        self.tiffRepresentation
    }
}

