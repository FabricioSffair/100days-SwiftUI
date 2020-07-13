//
//  ContentView.swift
//  guessTheFlag
//
//  Created by Fabricio Ssfair on 6/30/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

struct Opacity: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        content.opacity(amount)
    }
}

struct Rotate: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(Angle(degrees: amount), axis: (x: 0, y: 1, z: 0))
            .modifier(BorderColor(color: .green, width: 2))
    }
}

struct BorderColor: ViewModifier {
    let color: Color
    let width: CGFloat
    func body(content: Content) -> some View {
        content.overlay(Capsule().stroke(color, lineWidth: width))
            .shadow(color: .green, radius: 5)
    }
}

extension AnyTransition {
    static var opacity25: AnyTransition {
        .modifier(active: Opacity(amount: 1), identity: Opacity(amount: 0.25))
    }
    static var rotate360y: AnyTransition {
        .modifier(active: Rotate(amount: 0), identity: Rotate(amount: 360))
    }
    static var greenBorder: AnyTransition {
        .modifier(active: BorderColor(color: .black, width: 0), identity: BorderColor(color: .green, width: 2))
    }
}

extension View {
    func capsuledWithBorder() -> some View {
        self.modifier(CapsuledBorder())
    }
}

struct CapsuledBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 0.5))
            .shadow(color: .black, radius: 5)
    }
}

struct FlagImage: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .capsuledWithBorder()
    }
}


struct ContentView: View {
    
    let darkBlue = Color(red: 40/255, green: 48/255, blue: 72/255)
    let lightGrey = Color(red: 133/255, green: 147/255, blue: 152/255)
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var scoreMessage = ""
    @State private var scoreTitle = ""
    
    @State private var highlightCorrect = false
    @State private var highlightError = false
    @State private var disableAction = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [darkBlue, lightGrey]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                Spacer()
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.askQuestion()
                        }
                    }) {
                        if self.highlightCorrect {
                            FlagImage(imageName: self.countries[number])
                                .transition(number == self.correctAnswer ? .rotate360y : .opacity25)
                                .id(self.highlightCorrect)
                            .clipped()
                        } else if self.highlightError {
                            FlagImage(imageName: self.countries[number])
                                .transition(number == self.correctAnswer ? .greenBorder : .opacity25)
                                .id(self.highlightError)
                        } else {
                            FlagImage(imageName: self.countries[number])
                        }
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.trailing)
                }
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "Nice going!"
            score += 1
            self.highlightCorrect = true
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
            score = score == 0 ? score : score - 1
            self.highlightError = true
        }
//        showingAlert = true
    }
    
    func askQuestion() {
        self.highlightCorrect = false
        self.highlightError = false
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
