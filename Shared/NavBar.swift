//
//  NavBar.swift
//  Recipe-Builder
//
//  Created by jiarui on 2022/11/16.
//

import SwiftUI

struct NavBar: View {
    @State private var selection = 1
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    var body: some View {
        TabView(selection: $selection) {
            HomeView().tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
            }.tag(1)
            
            RecipeBookView().tabItem {
                VStack {
                    Image(systemName: "bookmark")
                    Text("MetaRecipe")
                }
                
            }.tag(2)
            
            Text("Profile").tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Profile")
                }
                
            }.tag(3)
        }
        .accentColor(.blue)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar().environmentObject(RecipeBook())
    }
}
