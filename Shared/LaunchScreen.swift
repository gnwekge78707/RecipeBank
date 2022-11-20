//
//  LaunchScreen.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm on 20/10/2022.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var buttonPressed = false
    @State private var showing = false
    @State private var logoInPostion = false
    @State private var animationBegun = false
    
    init() {}
    
    var body: some View {
        ZStack {
            if (buttonPressed) {
                NavBar().transition(.asymmetric(insertion: .slide, removal: .identity)).environmentObject(RecipeBook())
            } else {
                VStack {
                    ZStack {
                        ZStack {
                            Launch.logo
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: Launch.length)
                                .offset(x: animationBegun ? -130 : 0, y: 0)
                            title
                                .offset(x: 40, y: -10)
                                .opacity(logoInPostion ? 1 : 0)
                            message
                                .offset(x: 45, y: 23)
                                .opacity(logoInPostion ? 1 : 0)
                        }
                        GeometryReader { geo in
                            Button() {
                                buttonPressed.toggle()
                            } label: {
                                Text(Launch.buttonText)
                                    .frame(width: geo.size.width - 100)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(Launch.buttonCurvature)
                                    .position(x: geo.size.width / 2,
                                                y: geo.size.height - 100)
                                    .blur(radius: logoInPostion ? 0 : 100)
                            }
                                
                        }
                        
                    }
                    
                }
                .onAppear {
                    let seconds = 0.8
                    withAnimation(.easeIn(duration: seconds)) {
                        animationBegun.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                            withAnimation(.easeIn(duration: seconds)) {
                                logoInPostion.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var title: some View {
        Text(Launch.title.uppercased())
            .font(.system(size: Launch.titleSize))
            .foregroundColor(Launch.color)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
    }
    
    private var message: some View {
        Text(Launch.message)
            .font(.system(size: Launch.messageSize))
            .foregroundColor(Launch.color)
            .fontWeight(.bold)
    }
    
    private struct Launch {
        static let logo = Image("Logo")
        static let title = "Welcome"
        static let titleSize: CGFloat = 50
        static let message = "What's cooking?"
        static let messageSize: CGFloat = 18
        static let color = Color.green
        
        static let buttonText = "RecipeBank"
        static let buttonTextColor: Color = .white
        static let minButtonHeight: CGFloat = 80
        static let buttonCurvature: CGFloat = 15
        
        static let length: CGFloat = 75
        
        static let offset: CGFloat = 85
    }
    
}

    
struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
