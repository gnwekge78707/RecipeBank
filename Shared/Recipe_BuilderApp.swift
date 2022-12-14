//
//  Recipe_BuilderApp.swift
//  Shared
//
//  Created by youKnowWhoIAm on 20/10/2022.
//

import SwiftUI

@main
struct Recipe_BuilderApp: App {
    
    var body: some Scene {
        WindowGroup {
            #if !os(macOS)
            LaunchScreen().environmentObject(RecipeBook())
            #else
            LaunchScreen()
                .frame(minWidth: macOS.minWindowWidth,
                                 maxWidth: .infinity,
                                 minHeight: macOS.minWindowHeight,
                                 maxHeight: .infinity,
                                 alignment: .center)
                .environmentObject(RecipeBook())
            #endif
        }
        
    }
    
    private struct macOS {
        static let minWindowWidth = CGFloat(700)
        static let minWindowHeight = CGFloat(400)
    }
}
