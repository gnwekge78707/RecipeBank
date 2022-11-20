//
//  RecipeDetailView.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm on 08/10/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var recipe: Recipe
    @Environment(\.colorScheme) var colorScheme
    //@State private var recipeAmounts: [String]
    
    private var darkBG = LinearGradient(gradient: Gradient(colors: [.black, Color(hue: 0, saturation: 0, brightness: 0.15)]), startPoint: .top, endPoint: .bottom)
    private var lightBG = LinearGradient(gradient: Gradient(colors: [.white, Color(hue: 0, saturation: 0, brightness: 0.9)]), startPoint: .bottom, endPoint: .top)
    
    init(recipe: Recipe) {
        self.recipe = recipe
        //recipeAmounts = recipe.amounts?? []
        //recipeAmounts.append(" ")
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader{reader in
                    //Image(optionalData: recipe.image)
                    Image(optionalData: recipe.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        .offset(y: -reader.frame(in: .global).minY)
                        // going to add parallax effect....
                        .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY + 300)
                    
                }
                .frame(height: 280)
                
                VStack(alignment: .center, spacing: 15){
                    
                    
                    Text(recipe.name ?? ViewConstants.unnamed)
                        .font(.system(.title, design: .default))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    
                    
                    HStack(spacing: 10){
                        
                        ForEach(1..<5){_ in
                    
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    cookingKit
                    
                    discriptionSubView
                    
                    ingredientSubView
                    
                    instructionSubView
                    
                    commentSubView
             
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: -35)
            })
        }.edgesIgnoringSafeArea(.top)
        
        Spacer()
                       
        /*
        GeometryReader { geo in
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack {
                            Spacer(minLength: ViewConstants.imageOffset)
                            photo
                            title
                        }
                        .padding()
                        .frame(width: geo.size.width)
                        cookingKit
                        ingredients
                        instructions
                    }
                    
                }
                
                .ignoresSafeArea()
            }
            .background(colorScheme == .light ? lightBG : darkBG)
            .ignoresSafeArea()
        }
        */
    }
    
    @State var rotation = CGSize.zero
    
    @ViewBuilder
    private var photo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 45)
                .frame(width: ViewConstants.diameter, height: ViewConstants.diameter)
                .foregroundColor(.black)
                .scaleEffect(1.04)
                
                
            Image(optionalData: recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ViewConstants.diameter, height: ViewConstants.diameter)
                .background(Color.white.opacity(0.85))
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 45))
        }
        .rotation3DEffect(
            .degrees(Double(rotation.width * 0.6)),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        .rotation3DEffect(
            .degrees(Double(rotation.height * -0.3)),
            axis: (x: 1.0, y: 1.0, z: 0.0)
        )
        .gesture(DragGesture()
                    .onChanged { value in
                        rotation = value.translation
                    }
        
                    .onEnded { value in
                        rotation = CGSize.zero
                    })
        .animation(.easeOut)
    }
    
    private var cookingKit: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 2, content: {
                Image(systemName: "person.2")
                Text("Serves: \(2)")
            })
            HStack(alignment: .center, spacing: 2, content: {
                Image(systemName: "clock")
                Text("Prep: \(30)\("min")")
            })
            HStack(alignment: .center, spacing: 2, content: {
                Image(systemName: "flame")
                Text("Cooking: \(0)min")
            })
        }
        .font(.footnote)
        .foregroundColor(Color.gray)
    }
    
    private var ingredientSubView: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Spacer()
                Text("Ingredients")
                    .font(.system(size: 25, weight: .bold))
                    .modifier(BoxTitleModifier())
                Spacer()
            }

            VStack (alignment: .leading, spacing: 5) {
                ForEach(recipe.ingredients ?? [], id: \.self) { item in
                    let idx = (recipe.ingredients ?? []).firstIndex(of: item)
                    VStack (alignment: .leading, spacing: 5) {
                        HStack {
                            Text(item)
                                .font(.footnote)
                                .multilineTextAlignment(TextAlignment.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text((recipe.amounts ?? [])[idx!])
                                .font(.footnote)
                                .multilineTextAlignment(TextAlignment.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            //Text("ll")
                            /*
                            TextField("amount", text: $recipeAmounts[idx!])
                                .font(.footnote)
                                .frame(width: 100.0, height: 20.0)*/
                            
                        }.padding(.top, 5)
                        
                        Divider()
                    }
                }
                
            }
        }
        .modifier(BoxBackgroundModifier())
        .padding(.top, 15)
    }
    
    private var discriptionSubView: some View {
        
        VStack(alignment: .center, spacing: 10) {
        
            HStack {
                Spacer()
                Text("Description")
                    .font(.system(size: 25, weight: .bold))
                    .modifier(BoxTitleModifier())
                Spacer()
            }
            
            Text(recipe.describe ?? "一款表皮酥脆，麦香十足，软质奶酪内陷的欧式面包")
                .padding(.top, 5)
                .fixedSize(horizontal: false, vertical: true)
        }
        .modifier(BoxBackgroundModifier())
        .padding(.top, 15)
    }
    
    private var instructionSubView: some View {
        
        VStack(alignment: .leading, spacing: 10) {
        
            HStack {
                Spacer()
                Text("Instructions")
                    .font(.system(size: 25, weight: .bold))
                    .modifier(BoxTitleModifier())
                Spacer()
            }
                
            ForEach(recipe.instructions ?? [], id: \.self) { item in
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 15, height: 25, alignment: .center)
                        .imageScale(.large)
                        .font(Font.title.weight(.ultraLight))
                        .foregroundColor(Color.gray)
                    
                    Text(item)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .font(.system(.body, design: .default))
                        .fixedSize(horizontal: false, vertical: true)

                }
                .padding(.vertical, 10)
            }
        }
        .modifier(BoxBackgroundModifier())
        .padding(.top, 15)
    }
    
    private var commentSubView: some View {
        
        VStack(alignment: .leading, spacing: 10) {
        
            HStack {
                Spacer()
                Text("Comments")
                    .font(.system(size: 25, weight: .bold))
                    .modifier(BoxTitleModifier())
                Spacer()
            }
                
            ForEach(recipe.comments ?? [], id: \.self) { item in
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 15, height: 25, alignment: .center)
                        .imageScale(.large)
                        .font(Font.title.weight(.ultraLight))
                        .foregroundColor(Color.gray)
                    
                    Text(item)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .font(.system(.body, design: .default))
                        .fixedSize(horizontal: false, vertical: true)

                }
                .padding(.vertical, 10)
            }
        }
        .modifier(BoxBackgroundModifier())
        .padding(.top, 15)
    }
    
    private var title: some View {
        Text(recipe.name ?? ViewConstants.unnamed)
            .font(.largeTitle)
            .fontWeight(.bold)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
    }
    
    private var ingredients: some View {
        VStack(alignment: .leading) {
            
            Text(ViewConstants.ingredientsTitle)
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom], 0.3)
                
            
            ForEach(recipe.ingredients ?? [], id: \.self) { ingredient in
                if ingredient.replacingOccurrences(of: " ", with: "") != "" {
                    HStack {
                        Spacer().frame(width: ViewConstants.indent)
                        Text(ViewConstants.bullet + ingredient)
                            .font(.body)
                            .lineLimit(nil)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .opacity(0.85)
                    }
                }
            }
        }
        .padding([.horizontal])
    }
    
    private var instructions: some View {
        VStack(alignment: .leading) {
            
            Text(ViewConstants.instructionsTitle)
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom], 0.4)
            
            ForEach(recipe.instructions ?? [], id: \.self) { instruction in
                if instruction.replacingOccurrences(of: " ", with: "") != "" {
                    HStack(alignment: .top) {
                        Text(" \((recipe.instructions?.firstIndex(of: instruction))! + 1 ).")

                        Text(instruction)
                            .lineLimit(nil)
                            
                    }
                    .font(.body)
                    .foregroundColor(colorScheme == .light ? .black : .white)
                    .opacity(0.9)
                    
                    Spacer().frame(height: ViewConstants.gap)
                }
            }
        }
        .padding([.horizontal, .top])
    }
    
    private struct ViewConstants {
        // Recipe Title
        static let unnamed = "Unnamed Recipe Example"
        static let imageOffset: CGFloat = 80
        
        // Ingredients & Instructions
        static let ingredientsTitle = "Ingredients"
        static let color: Color = .green
        static let bgColor: Color = .green.opacity(0.7)
        static let stroke: CGFloat = 2
        static let boxRadius: CGFloat = 25
        static let instructionsTitle = "Instructions"
        static let indent: CGFloat = 12
        static let gap: CGFloat = 8
        
        static let bullet: String = "• "
        
        // Photo Constants
        static let diameter: CGFloat = 200
        static let borderColor: Color = .green
        static let borderWidth: CGFloat = 5
        static let shadowRadius: CGFloat = 6
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static let recipe = Recipe(context: RecipeStoreController.instance.container.viewContext)
    /*
    
    let img = UIImage(systemName: "food-1")
    recipe.image = img?.imageData*/
    
    static var previews: some View {
        recipe.name = "布理奶酪法包"
        recipe.ingredients = ["高精面粉", "水", "酵母", "盐", "布理奶酪或蓝纹奶酪"]
        recipe.amounts = ["300g", "250g", "5g", "3g", "适量"]
        recipe.instructions = ["混合粉类，合水，揉面至大概光滑", "醒面十五分钟，加奶酪块揉至光滑", "每发酵30min折叠面团一次，重复两到三次", "200度烤制30分钟"]
        recipe.image = UIImage(named: "food-3")?.imageData
        
        return Group {
            RecipeDetailView(recipe: recipe)
            RecipeDetailView(recipe: recipe).preferredColorScheme(.dark)
        }
    }
}
