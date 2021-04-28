//
//  ContentView.swift
//  RPSGame
//
//  Created by Fabricio Ssfair on 7/4/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

enum MatchResult {
    case win, lose, tie
}

struct TitleModifier: ViewModifier {
    @State var foregroundColor: Color = .white
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(foregroundColor)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func titleText(with foregroundColor: Color = .white) -> some View {
        self.modifier(TitleModifier(foregroundColor: foregroundColor))
    }
}

struct TitleView: View {
    @State var title: String
    @State var color: Color = .white
    var body: some View {
        Text(title)
            .fontWeight(.black)
            .titleText(with: color)
    }
}

enum GameObject: Int, CaseIterable {
    case rock = 0, paper, scissors

    var image: Image {
        return Image("\(self)")
            .renderingMode(.original)
    }

    func shouldWinGame(from otherObject: GameObject) -> MatchResult {
        guard otherObject.rawValue != self.rawValue else { return .tie }
        switch self {
        case .rock:
            return otherObject == .scissors ? .win : .lose
        case .paper:
            return otherObject == .rock ? .win : .lose
        case .scissors:
            return otherObject == .paper ? .win : .lose
        }
    }
}

struct RPSView: View {

    @State var cpuObject: GameObject = GameObject.allCases[Int.random(in: 0..<GameObject.allCases.count)]
    @State private var shouldShowOpponentObject: Bool = false
    @State private var selectedObjectIndex: Int = 0
    @State private var title: String = "Select Rock, Paper or Scissors"
    @State private var score: Int = 0
    @State private var numOfPlays = 0
    @State private var showScore: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Beige"), Color("IceBlue")]),
                           startPoint: .bottomTrailing,
                           endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Spacer()
                Spacer()
                TitleView(title: title)
                    .id(shouldShowOpponentObject)
                if shouldShowOpponentObject {
                    cpuObject.image
                }
                HStack {
                    ForEach(0..<GameObject.allCases.count) { index in
                        if !self.shouldShowOpponentObject || index == self.selectedObjectIndex {
                            Button(action: {
                                self.selectedObjectIndex = index
                                self.didSelectObject(GameObject.allCases[index])
                            }) {
                                GameObject.allCases[index].image
                            }
                        }
                    }.id(shouldShowOpponentObject)
                }
                if shouldShowOpponentObject {
                    Button(action: {
                        self.reset()
                    }) { TitleView(title: "Play Again") }
                }
                Spacer()
                if showScore {
                    HStack {
                        Text("Game is over!\nFinal score: \(score)")
                            .titleText()
                    }
                }
                Spacer()
            }
        }
    }

    func didSelectObject(_ object: GameObject) {
        numOfPlays += 1
        let matchResult = object.shouldWinGame(from: cpuObject)
        if matchResult == .win {
            score += 1
            title = "You won this round"
        } else if matchResult == .lose {
            score = score == 0 ? score : (score - 1)
            title = "You lost this round"
        } else {
            title = "It's a tie!"
        }
        if numOfPlays == 10 {
            numOfPlays = 0
            showScore = true
        }
        shouldShowOpponentObject = true
        print(cpuObject)
        print(matchResult)
    }

    func reset() {
        showScore = false
        cpuObject = GameObject.allCases[Int.random(in: 0..<GameObject.allCases.count)]
        shouldShowOpponentObject = false
        selectedObjectIndex = 0
        title = "Select Rock, Paper or Scissors"
    }
}

struct RPSView_Previews: PreviewProvider {
    static var previews: some View {
        RPSView()
    }
}
