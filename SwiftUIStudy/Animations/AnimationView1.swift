//
//  ContentView.swift
//  Animations
//
//  Created by Fabricio Ssfair on 7/8/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

// Transition
struct Animation7: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    // PREVIEW DOES NOT WORK 100%, running on simulator works
//                    .transition(.scale)
            }
        }
    }
}

// Gesture
struct Animation6: View {
    
    let letters = Array("Hello SwiftUI")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 100))
            }
        }
        .gesture(
            DragGesture()
                .onChanged {self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
            }
        )
    }
}

// Gesture
struct Animation5: View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            self.dragAmount = .zero
                        }
                }
        )
    }
}

// Animation order
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

// Explicit animation
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

// Animation controlled
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

// Animation start
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

struct Animation1Previes: PreviewProvider {
    static var previews: some View {
        Animation1()
    }
}
