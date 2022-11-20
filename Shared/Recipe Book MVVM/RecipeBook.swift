//
//  RecipeBook.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm on 09/10/2022.
//

import SwiftUI
import CoreData

/// The RecipeBook is the view model that represents all the recipes a user has,
/// it communicates with the PersistenceController to load these recipes
class RecipeBook: ObservableObject {
    @Published var recipes: [Recipe]? = [] // checked in UI for error
    private let controller = RecipeStoreController.instance
    
    init() {
        refresh()
        
        if recipes?.count == 0 {
            controller.add(name: "海鲜炒饭",
                           ingredients: ["隔夜米饭", "鸡蛋", "小葱", "胡椒", "鸡粉", "干贝", "配菜-胡萝卜等"],
                           amounts: ["300g", "1-2个", "适量", "适量", "适量", "适量", "适量"],
                           instructions: ["花生油炒蛋至香", "加入米饭，干炒", "提前炒小料，米饭炒出锅气后加入", "出锅前调味，锅边淋入酱油"],
                           image: UIImage(named: "food-4")?.imageData,
                           describe: "炒饭还有什么可说的",
                           comments: ["简单好吃"]
            )
            controller.add(name: "番茄罗勒意面",
                           ingredients: ["PASTA-长条型", "水", "盐", "水果番茄", "胡椒", "帕玛森奶酪", "罗勒", "橄榄油大蒜"],
                           amounts: ["300g", "大量", "少许", "适量", "适量", "适量", "适量", "适量"],
                           instructions: ["水中加盐，煮意面至八成熟", "橄榄油炒蒜，加入番茄翻炒", "橄榄油番茄乳化之后加入面条", "出锅前调味，加入阿玛森芝士，加罗勒"],
                           image: UIImage(named: "food-3")?.imageData,
                           describe: "味道清新的意面",
                           comments: ["简单好吃"]
            )
            controller.add(name: "布理奶酪乡村包",
                           ingredients: ["高筋面粉", "水", "酵母", "盐", "布理奶酪或蓝纹奶酪"],
                           amounts: ["300g", "270g", "5g", "3g", "适量"],
                           instructions: ["混合粉类，合水，揉面至大概光滑", "醒面十五分钟，加奶酪块揉至光滑", "每发酵30min折叠面团一次，重复两到三次", "200度烤制30分钟"],
                           image: UIImage(named: "food-6")?.imageData,
                           describe: "一款表皮酥脆，麦香十足，软质奶酪内陷的欧式面包",
                           comments: [""]
            )
            controller.add(name: "那不勒斯披萨",
                           ingredients: ["高筋面粉", "水", "酵母", "盐", "意大利番茄罐头", "马苏里拉奶酪球", "罗勒", "大蒜橄榄油"],
                           amounts: ["300g", "240g", "5g", "3g", "1/2罐", "100g", "适量", "适量"],
                           instructions: ["混合粉类，合水，揉面至大概光滑", "醒面十五分钟", "发酵50min", "用橄榄油和蒜炒制番茄糊, 一层蕃茄糊一层奶酪组装", "250度烤制10分钟"],
                           image: UIImage(named: "food-7")?.imageData,
                           describe: "正宗的那不勒斯风味",
                           comments: ["做的时候发现，火要尽可能大，番茄可以少放一些，奶酪要足够"]
            )
            controller.add(name: "三杯鸡",
                           ingredients: ["走地鸡", "罗勒", "配菜（如甜椒）", "麻油", "米酒", "头抽", "糖，盐，胡椒粉，淀粉", "大蒜，姜"],
                           amounts: ["一只", "少许", "适量", "一杯", "一杯", "一杯", "适量", "适量"],
                           instructions: ["鸡肉切块，浸泡出血水，用盐、姜末、花生油、淀粉、胡椒粉腌制片刻", "热锅加姜片爆香，加入鸡肉煎至金黄，放蒜片爆香", "倒入米酒，头抽，开始焖10min", "收汁的过程中加入麻油，加入配菜大火爆炒至断生", "放大量罗勒叶，出锅前再淋一圈香油"],
                           image: UIImage(named: "food-8")?.imageData,
                           describe: "下饭很不错",
                           comments: ["技术总结：罗勒一定后放，起锅前淋香油效果不错", "米酒选偏甜的更香"]
            )
        }
    }
    
    // MARK: - Intents
    /// This function reloads recipes, and should be called to update the recipes the user
    /// can see
    func refresh() {
        recipes = controller.fetchSortedRecipes()
    }
    
    /// This function tells the persistence controller to delete a recipe from core data once a user deletes it
    func delete(at offsets: IndexSet) {
        controller.delete(at: offsets)
        refresh()
    }
}
