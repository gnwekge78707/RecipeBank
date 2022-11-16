//
//  RecipeCardView.swift
//  Recipe-Builder
//
//  Created by jiarui on 2022/11/16.
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
        recipe.name = "布理奶酪法包"
        recipe.ingredients = ["高精面粉", "水", "酵母", "盐", "布理奶酪或蓝纹奶酪"]
        recipe.amounts = ["300g", "250g", "5g", "3g", "适量"]
        recipe.instructions = ["混合粉类，合水，揉面至大概光滑", "醒面十五分钟，加奶酪块揉至光滑", "每发酵30min折叠面团一次，重复两到三次", "200度烤制30分钟"]
        recipe.image = UIImage(named: "food-3")?.imageData
        
        return Group {
            RecipeCardView(recipe: recipe).previewLayout(.sizeThatFits)
                .colorScheme(.light)
        }
    }

}
