//
//  RecipeListPreview.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 28/08/2021.
//

import SwiftUI

struct RecipeListPreview: View {
    @ObservedObject private var recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack {
            Image(optionalData: recipe.image)
                .resizable()
                .frame(width: Row.length, height: Row.length)
                .cornerRadius(Row.corner)
                .overlay(RoundedRectangle(cornerRadius: Row.corner)
                            .stroke(Color.black, lineWidth: 1.5))
                
            
            Text(recipe.name ?? Row.defaultName)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .foregroundColor(.black)
        }
    }
    
    private struct Row {
        static let defaultName: String = "Unnamed Recipe"
        static let corner: CGFloat = 15
        static let length: CGFloat = 55
    }
}
