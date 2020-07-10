//
//  ContentView.swift
//  Animations
//
//  Created by Fabricio Ssfair on 7/8/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

struct Animation4: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button("Tap me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
        .foregroundColor(.white)
        .animation(.easeIn)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 3))
    }
}

struct Animation3: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 10, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 2, y: 1, z: 1))
    }
}

struct Animation2: View {
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        print(animationAmount)
        return VStack {
            Stepper("Scale Amount", value:
                $animationAmount.animation(.linear), in: 1...10)
            Spacer()
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

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
