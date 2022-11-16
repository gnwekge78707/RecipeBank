//
//  RecipeDataStore.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 01/06/2021.
//

import Foundation
import SwiftUI

struct PreviewData {
    @Environment(\.managedObjectContext) static var moc
    
    static func recipes() -> [Recipe] {
        let recipe1 = Recipe(context: PreviewData.moc)
        let recipe2 = Recipe(context: PreviewData.moc)
        
        recipe1.id = UUID()
        recipe2.id = UUID()
        
        recipe1.name = "Cheesy Pasta"
        recipe2.name = "Fish and Chips"
        
        recipe1.image = nil
        recipe2.image = nil
        
        recipe1.ingredients = ["Cheese", "Single Cream", "Pasta", "Salt", "Pepper"]
        recipe2.ingredients = ["Fish", "Salt", "Vinegar", "Chips"]
        
        recipe1.instructions = ["Add cream to hob",
                                "Increase heat slowly",
                                "Slowly adding cheese",
                                "Boil pasta alongside",
                                "Add salt",
                                "Mix well",
                                "Add pepper",
                                "Mix well",
                                "Add cream to pasta once done",
                                "Add together and enjoy"]
        
        recipe2.instructions = ["Cook fish", "Cook chips in preffered style", "Add salt & vinegar", "Combine and enjoy"]
        
        return [recipe1, recipe2]
    }
}
