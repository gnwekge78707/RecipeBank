//
//  RecipePreview.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 22/05/2021.
//

import SwiftUI

struct RecipeGridPreview: View {
    @ObservedObject private var recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        ZStack {
            Image(optionalData: recipe.image)
                .centerCropped()
                .aspectRatio(16/11, contentMode: .fill)
                .clipped()
            
            VStack {
                Spacer()
                Text(recipe.name ?? Row.defaultName)
                    .font(.body)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding([.top], 5)
                    .padding([.bottom])
                    .background(Color.white.opacity(Row.textTransparency)
                                    .frame(width: 500)
                                    )
            }
        }
        .cornerRadius(20)
    }
    
    private struct Row {
        static let defaultName: String = "Unnamed Recipe"
        static let textTransparency = 0.85
    }
}



struct RecipeCompactViewPreview_Previews: PreviewProvider {
    static let recipe = Recipe(context: RecipeStoreController.instance.container.viewContext)
    
    static var previews: some View {
        recipe.name = "A really yummy Recipe"
        
        return RecipeGridPreview(recipe)
    }
}
