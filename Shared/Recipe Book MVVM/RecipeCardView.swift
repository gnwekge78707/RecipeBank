//
//  RecipeCardView.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm on 2022/11/16.
//

import SwiftUI

import SwiftUI

struct RecipeCardView: View {
    
    // MAKR: PROPERTIES
    @ObservedObject var recipe: Recipe
    @State private var showModal: Bool = false

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            //ImageLoaderView(imageUrl: recipe.image)
            Image(optionalData: recipe.image)
                .resizable()
                .scaledToFill()
            
            VStack(alignment: .leading, spacing: 12) {
                // TITLE
                Text(recipe.name ?? "unamed")
                    .font(.system(.headline, design: .default))
                
                // RATES
                HStack(alignment: .center, spacing: 5) {
                    ForEach(1...(4), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.body)
                            .foregroundColor(Color.yellow)
                    }
                }
                
                // COOKING
                HStack(alignment: .center, spacing: 12) {
                    HStack(alignment: .center, spacing: 2, content: {
                        Image(systemName: "person.2")
                        Text("Serves: \(2)")
                    })
                    HStack(alignment: .center, spacing: 2, content: {
                        Image(systemName: "clock")
                        Text("Prep: \(30)\("min")")
                    })
                    HStack(alignment: .center, spacing: 2, content: {
                        Image(systemName: "flame")
                        Text("Cooking: \(0)min")
                    })
                }
                .font(.footnote)
                .foregroundColor(Color.gray)
                
            }
            .padding()
            .padding(.bottom, 12)
                
        }
        .background(Color("ColorBackgroundAdaptive"))
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 0)
        .onTapGesture {
            self.showModal = true
        }
        .sheet(isPresented: self.$showModal) {
            RecipeDetailView(recipe: self.recipe)
                
        }
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static let recipe = Recipe(context: RecipeStoreController.instance.container.viewContext)
    /*
    
    let img = UIImage(systemName: "food-1")
    recipe.image = img?.imageData*/
    
    static var previews: some View {
        recipe.name = "??????????????????"
        recipe.ingredients = ["????????????", "???", "??????", "???", "???????????????????????????"]
        recipe.amounts = ["300g", "250g", "5g", "3g", "??????"]
        recipe.instructions = ["?????????????????????????????????????????????", "?????????????????????????????????????????????", "?????????30min???????????????????????????????????????", "200?????????30??????"]
        recipe.image = UIImage(named: "food-3")?.imageData
        
        return Group {
            RecipeCardView(recipe: recipe).previewLayout(.sizeThatFits)
                .colorScheme(.light)
        }
    }

}
