//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView(content: {
            Form {
                NavigationLink(destination: ExpenseView()) {
                    Text("iExpense")
                }
                NavigationLink(destination: GuessTheFlagView()) {
                    Text("Guess The Flag")
                }
                NavigationLink(destination: Animation5()) {
                    Text("Animations")
                }
                NavigationLink(destination: WordScrambleView()) {
                    Text("Word Scramble")
                }
                NavigationLink(destination: BetterRestView()) {
                    Text("Better Rest")
                }
                NavigationLink(destination: RPSView()) {
                    Text("Rock Paper Scissors")
                }
                NavigationLink(destination: ConversionView()) {
                    Text("Conversion")
                }
                NavigationLink(destination: ModifiersView()) {
                    Text("Modifiers")
                }
                NavigationLink(destination: WeSplitView()) {
                    Text("We Split")
                }
            }
            .navigationTitle("Home")
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
