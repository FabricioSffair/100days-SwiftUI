//
//  ContentView.swift
//  guessTheFlag
//
//  Created by Fabricio Ssfair on 6/30/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

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
    
    @State private var showingAlert = false
    
    @State private var score = 0
    
    @State private var scoreMessage = ""
    @State private var scoreTitle = ""
    
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
                        self.flagTapped(number)
                    }) {
                        FlagImage(imageName: self.countries[number])
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
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                    self.askQUestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "Nice going!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
            score = score == 0 ? score : score - 1
        }
        showingAlert = true
    }
    
    func askQUestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
