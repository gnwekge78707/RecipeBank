//
//  RecipeBookView.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm on 08/10/2022.
//

import SwiftUI

struct RecipeBookView: View {
    @EnvironmentObject private var recipeBook: RecipeBook
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.editMode) var editMode
    @State private var buildingRecipe = false
    @State private var editingRecipe = false
    @State private var viewMode: ViewMode = .grid
    
    var items: [GridItem] {
        [GridItem(.adaptive(minimum: 120), spacing: 10),
         GridItem(.adaptive(minimum: 120), spacing: 10)]
    }
    
    private enum ViewMode {
        case grid, list;
    }
    
    var body: some View {
        NavigationView {
            if (self.recipeBook.recipes == nil) {
                errorMessage
            } else if self.recipeBook.recipes!.count > 0 {
                list
            } else {
                emptyView
            }
        }
        .nativePullout(isPresented: $buildingRecipe) {
            RecipeBuilderForm(builder: RecipeBuilder(book: recipeBook))
                .macOSPadding()
                .iOSNavigationView()
        }
    }
    
    private var switchViewMode: some View {
        Button() {
            withAnimation {
                switch viewMode {
                case .grid:
                    viewMode = .list
                case .list:
                    viewMode = .grid
                }
            }
        } label: {
            Image(systemName: viewMode == .grid ?
                    "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
        }
        .plainButtonStyleMacOS()
    }
    
    private var openBuildRecipe: some View {
        Button() {
            buildingRecipe.toggle()
        } label: {
            RV.buildIcon
        }
        .plainButtonStyleMacOS()
    }
    
    private var errorMessage: some View {
        Text("The database could not be loaded. This may be due to the device being out of storage, or may require an app reinstall if the problem persists.")
            .multilineTextAlignment(.center).frame(width: 300)
            .frame(minWidth: 300)
            .navigationTitle(RV.title)
    }
    
    private var list: some View {
        switch viewMode {
        case .grid:
            return AnyView(GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: items, spacing: 10) {
                        ForEach (recipeBook.recipes!) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)
                                            .navigationBarItems(trailing: edit)
                                            .nativePullout(isPresented: $editingRecipe, content: {
                                                
                                                RecipeBuilderForm(builder: RecipeBuilder(recipe: recipe, book: recipeBook))
                                                    .macOSPadding()
                                                    .iOSNavigationView()
                                                
                                            })
                            ) { // What is wrapped in navigation link
                                RecipeGridPreview(recipe)
                                    
                            }
                        }
                    }
                    .padding()
                    
                }
            }
            .navigationTitle(RV.title)
            .navigationBarItems(leading: RV.naviLeading,
                                trailing: trailingButtons
                                .macOSPadding(5)
                                .foregroundColor(.blue))
            )
        case .list:
            return AnyView(List {
                ForEach (recipeBook.recipes!) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)
                                    .navigationBarItems(trailing: edit)
                                    .nativePullout(isPresented: $editingRecipe, content: {
                                        
                                        RecipeBuilderForm(builder: RecipeBuilder(recipe: recipe, book: recipeBook))
                                            .macOSPadding()
                                            .iOSNavigationView()
                                        
                                    })
                    ) { // What is wrapped in navigation link
                        RecipeListPreview(recipe)
                    }
                }
                .onDelete(perform: recipeBook.delete)
            }
            .listStyle(InsetListStyle())
            .navigationTitle(RV.title)
            .navigationBarItems(leading: RV.naviLeading,
                                trailing: trailingButtons
                                .macOSPadding(5)
                                .foregroundColor(.blue))
            )
        }
    }
    
    private var trailingButtons: some View {
        HStack {
            switchViewMode
            openBuildRecipe
        }
    }
    
    private var edit: some View {
        Button("Edit") {
            editingRecipe.toggle()
        }
        .padding()
    }
    
    private var emptyView: some View {
        Text("No recipes. Create a recipe using the hammer button above.")
            .multilineTextAlignment(.center).frame(width: 300)
            .frame(minWidth: 300)
            .navigationTitle(RV.title)
            .navigationBarItems(leading: RV.naviLeading,
                                trailing: Button() {
                                    buildingRecipe.toggle()
                                } label: {
                                    RV.buildIcon
                                }
                                .plainButtonStyleMacOS()
                                .macOSPadding(5)
                                .foregroundColor(.blue)
                                
            )
            
    }
    
    private struct RV {
        static let title = "Recipe Bank"
        static let buildIcon: some View = Image(systemName: "hammer")
        
        #if os(iOS)
        static let naviLeading: some View = EditButton()
        
        #elseif os(macOS)
        static let naviLeading: some View = EmptyView()
        #endif
    }
}

struct RecipeBookView_Previews: PreviewProvider {
    static let recipebook = RecipeBook()
    
    static var previews: some View {
        RecipeBookView().preferredColorScheme(.light).environmentObject(recipebook)
    }
}
