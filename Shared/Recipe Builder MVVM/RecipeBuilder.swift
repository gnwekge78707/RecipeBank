//
//  RecipeBuilder.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 09/07/2021.
//

import SwiftUI
import CoreData

// ViewModel for creating a new recipe, and editing a recipe
class RecipeBuilder: ObservableObject {
    private var book: RecipeBook // to call refresh when neccessary
    @Published var name: String = ""
    @Published var ingredients: [String] = [""]
    @Published var amounts: [String] = [""]
    @Published var instructions: [String] = [""]
    @Published var image: Data? = nil
    private var controller = RecipeStoreController.instance
    private var recipe: Recipe?
    
    init(recipe: Recipe? = nil, book: RecipeBook) {
        self.recipe = recipe // used to check if a recipe was loaded
        self.book = book
        setRecipe(recipe)
    }
    
    func getBook() -> RecipeBook {
        return self.book
    }
    
    func save() {
        // if a recipe not loaded
        if recipe == nil {
            self.controller.add(name: self.name, ingredients: self.ingredients, amounts: self.amounts,
                                instructions: self.instructions, image: self.image)
            
        } else {
            // id here is nil
            self.controller.edit(id: recipe!.id!, name: self.name, ingredients: self.ingredients, amounts: self.amounts, instructions: self.instructions, image: self.image)
        }
        book.refresh()
    }
    
    func setRecipe(_ recipe: Recipe?) {
        if recipe != nil {
            self.name = recipe!.name!
            self.image = recipe!.image
            self.ingredients = recipe!.ingredients!
            self.amounts = recipe!.amounts!
            self.instructions = recipe!.instructions!
        } else { return }
    }
    
    private func stringIsEmpty(_ string: String) -> Bool {
        string.replacingOccurrences(of: " ", with: "") == ""
    }
}
