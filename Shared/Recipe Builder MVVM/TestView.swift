//
//  TestView.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 26/06/2021.
//

import SwiftUI

struct TestView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: RecipesView()) {
                Text("Press me")
            }
        }
        
//        NavigationView {
//            VStack {
//                Text("Hello World")
//                NavigationLink(destination: RecipesView()) {
//                    Text("Do something")
//                }
//            }
//        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
