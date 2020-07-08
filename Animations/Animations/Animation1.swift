//
//  ContentView.swift
//  Animations
//
//  Created by Fabricio Ssfair on 7/8/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

struct Animation1: View {
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap me") {
//            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2-animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
            )
        )
//            .scaleEffect(animationAmount)
            .onAppear {
                self.animationAmount = 2
        }
        //        .animation(.interpolatingSpring(stiffness: 50, damping: 1))
    }
}

struct Animation1_Previes: PreviewProvider {
    static var previews: some View {
        Animation1()
    }
}
