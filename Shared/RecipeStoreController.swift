//
//  PersistenceController.swift
//  Recipe-Builder
//

import CoreData
import SwiftUI

class RecipeStoreController {
    static let instance = RecipeStoreController("RecipeBuilderModel")
    let container: NSPersistentContainer
    
    init(_ name: String) {
        container = NSPersistentCloudKitContainer(name: name)
        container.loadPersistentStores { (description, error) in
            
            if error != nil {
                print("Failed to load persistent stores from CloudKit container for data model: \(name) : \(error!.localizedDescription)")
                return
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        /*
         let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Item")
         fetchRequest.resultType = .countResultType
         let count = (try? container.viewContext.count(for: fetchRequest)) ?? 0
         print(count)
         */
        
        /*
        if (container.accessibilityElementCount() == 0) {
            self.add(name: "布理奶酪乡村包",
                           ingredients: ["高筋面粉", "水", "酵母", "盐", "布理奶酪或蓝纹奶酪"],
                           amounts: ["300g", "270g", "5g", "3g", "适量"],
                           instructions: ["混合粉类，合水，揉面至大概光滑", "醒面十五分钟，加奶酪块揉至光滑", "每发酵30min折叠面团一次，重复两到三次", "200度烤制30分钟"],
                           image: UIImage(named: "food-6")?.imageData
            )
            self.add(name: "那不勒斯披萨",
                           ingredients: ["高筋面粉", "水", "酵母", "盐", "意大利番茄罐头", "马苏里拉奶酪球", "罗勒", "大蒜橄榄油"],
                           amounts: ["300g", "240g", "5g", "3g", "1/2罐", "100g", "适量", "适量"],
                           instructions: ["混合粉类，合水，揉面至大概光滑", "醒面十五分钟", "发酵50min", "用橄榄油和蒜炒制番茄糊, 一层蕃茄糊一层奶酪组装", "250度烤制10分钟"],
                           image: UIImage(named: "food-7")?.imageData
            )
            self.add(name: "三杯鸡",
                           ingredients: ["走地鸡", "罗勒", "配菜（如甜椒）", "麻油", "米酒", "头抽", "糖，盐，胡椒粉，淀粉", "大蒜，姜"],
                           amounts: ["一只", "少许", "适量", "一杯", "一杯", "一杯", "适量", "适量"],
                           instructions: ["鸡肉切块，浸泡出血水，用盐、姜末、花生油、淀粉、胡椒粉腌制片刻", "热锅加姜片爆香，加入鸡肉煎至金黄，放蒜片爆香", "倒入米酒，头抽，开始焖10min", "收汁的过程中加入麻油，加入配菜大火爆炒至断生", "放大量罗勒叶，出锅前再淋一圈香油"],
                           image: UIImage(named: "food-8")?.imageData
            )
        }*/
    }
    
    func add(name: String, ingredients: [String], amounts: [String], instructions: [String], image: Data?, describe: String, comments: [String]) {
        let ctx = self.container.viewContext
        let recipe = Recipe(context: ctx)
        
        recipe.id = UUID()
        recipe.name = name
        recipe.ingredients = ingredients
        recipe.amounts = amounts
        recipe.instructions = instructions
        recipe.image = image
        recipe.describe = describe
        recipe.comments = comments
        
        ctx.insert(recipe)
        if ctx.hasChanges {
            do {
                try ctx.save()
            } catch {
                print("Saving new recipe has failed")
            }
        }
    }
    
    func edit(id: UUID, name: String, ingredients: [String], amounts: [String], instructions: [String], image: Data?, describe: String, comments: [String]) {
        guard let recipe = get(with: id) else {
            add(name: name, ingredients: ingredients, amounts: amounts, instructions: instructions, image: image, describe: describe, comments: comments)
            return
        }
        print("Recipe with id \(id) loaded")
        
        recipe.name = name
        recipe.ingredients = ingredients
        recipe.amounts = amounts
        recipe.instructions = instructions
        recipe.image = image
        recipe.describe = describe
        recipe.comments = comments
        
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Saving recipe edits has failed")
            }
        }
        print("Recipe with id \(id) edited")
    }
    
    func get(with id: UUID) -> Recipe? {
        let predicate = NSPredicate(format: "id == %@", id as NSUUID)
        let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")
        fetchRequest.predicate = predicate
        
        let recipes = try? container.viewContext.fetch(fetchRequest)
        print("Fetch req with id completed")
        print("Fetched recipes: \(recipes ?? [])")
        return recipes?.first!
    }
    
    func fetchRecipes() -> [Recipe]? {
        try? container.viewContext.fetch(NSFetchRequest<Recipe>(entityName: "Recipe"))
    }
    
    func fetchSortedRecipes(sortDescriptors: [NSSortDescriptor] =  [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)]) -> [Recipe]? {
        
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        request.sortDescriptors = sortDescriptors
        
        return try? container.viewContext.fetch(request)
    }
    
    func delete(at offsets: IndexSet) {
        // Delete recipe from managed object context
        for index in offsets {
            let recipe = fetchSortedRecipes()![index]
            container.viewContext.delete(recipe)
        }
        
        // save changes
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
            }
        } catch {
            print("Deleting failed in RecipesBook()")
        }
    }
}
