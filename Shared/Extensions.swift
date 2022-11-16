//
//  Extensions.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 16/07/2021.
//

import SwiftUI

// extensions for both iOS and macOS
// extensions that work natively are found in iOS/iOS.swift and macOS/macOS.swift in the project

extension Image {
    
    // for use in RecipeRowView, the modifier that will return an image suitable
    func rowImage() -> some View {
        return self
            .resizable()
            .frame(width: RRIC.squareLength, height: RRIC.squareLength)
            .cornerRadius(RRIC.corner)
            .overlay(RoundedRectangle(cornerRadius: RRIC.corner)
                        .stroke(Color.black, lineWidth: RRIC.strokeSize)
            )
            .padding(RRIC.paddingAmount)
        
    }
    
    // Recipe Row Image Constants
    private struct RRIC {
        static let squareLength: CGFloat = 100
        static let corner: CGFloat = 20
        static let strokeSize: CGFloat = 1.5
        static let paddingAmount: CGFloat = 3
    }
    
    // For use in the RecipeBuilderForm, the preview image shown when a user selects an image to represent their photo
    func builderStyle() -> some View {
        self
            .resizable()
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(25.0)))
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
    
    init(optionalData: Data?) {
        if optionalData == nil {
            self = Image("Logo")
        } else {
            self = Image(uiImage: UIImage(data: optionalData!)!)
        }
    }
}
