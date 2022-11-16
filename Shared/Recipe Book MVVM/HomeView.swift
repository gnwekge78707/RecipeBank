//
//  HomeView.swift
//  Recipe-Builder
//
//  Created by jiarui on 2022/11/16.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var recipeBook: RecipeBook
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    
                    // MARK: - HEADER
                    
                    Image("header_image")
                        .resizable()
                        .scaledToFit()
                    
                    RecipeRowView().environmentObject(recipeBook)
                    // MARK: - CATEGORIES
                    /*
                    VStack(alignment: .leading) {
                        Text("Favorite")
                            .font(.headline)
                            .padding(.leading, 15)
                            .padding(.top, 5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(recipeBook.recipes!) { item in
                                    RecipeItem(recipe: item)
                                }
                            }
                        }
                        .frame(height: 185)
                    }*/
                    
                    
                    // MARK: - RECIPE CARDS
                    
                    Text("All Recipes")
                        .fontWeight(.bold)
                        .modifier(TitleModifier())
                    
                    VStack(alignment: .center, spacing: 20) {
                        
                        ForEach(recipeBook.recipes!) { item in
                            RecipeCardView(recipe: item)
                        }
                    }
                    .frame(maxWidth: 640)
                    .padding(.horizontal)
                    .padding(.bottom, 160)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .padding(0)
                
        }
    }
}





struct HomeView_Previews: PreviewProvider {
    static let recipebook = RecipeBook()

    
    static var previews: some View {
        HomeView().environmentObject(recipebook)
    }
}
