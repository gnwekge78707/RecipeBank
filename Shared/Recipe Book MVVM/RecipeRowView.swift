//
//  RecipeRowView.swift
//  RecipeApp
//
//  Created by mt on 11.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI

struct RecipeRowView: View {
    @EnvironmentObject private var recipeBook: RecipeBook
    
    var body: some View {
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
        }
    }
}


struct RecipeItem: View {
    
    // MARK: - PROPERTIEIS
    @ObservedObject var recipe: Recipe
    @State private var showModal: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                Image(optionalData: recipe.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 155, height: 155, alignment: .center)
                    
                HStack {
                    Image(systemName: "person.2")
                        .foregroundColor(Color.white)
                        .font(.callout)
                        .padding(.leading, 5)
                    
                    
                    Text("\(2)")
                        .foregroundColor(Color.white)
                        .font(.callout)
                    
                    Spacer()
                    
                    Text("\(30) min")
                        .foregroundColor(Color.white)
                        .font(.callout)
                        .padding(.trailing, 5)
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                        .padding(.top, -20)
                )
                
            }
            .cornerRadius(5)
            
            Text(recipe.name ?? "unamed")
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
        .onTapGesture {
            self.showModal = true
        }
        .sheet(isPresented: self.$showModal) {
            RecipeDetailView(recipe: self.recipe)
        }
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static let recipebook = RecipeBook()

    static var previews: some View {
        RecipeRowView().environmentObject(recipebook)
    }
}
