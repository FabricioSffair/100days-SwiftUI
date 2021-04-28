//
//  WordScramble.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

struct WordScrambleView: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0

    var body: some View {

        VStack {
            TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
            List(usedWords, id: \.self) {
                Image(systemName: "\($0.count).circle")
                Text($0)
            }
            Text("\(score)")
                .fontWeight(.black)
                .font(.largeTitle)
                .multilineTextAlignment(.trailing)
                .padding([.bottom], 20)
        }
        .navigationBarTitle(rootWord)
        .onAppear(perform: startGame)
        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            showError(title: "Word is too short", message: "Use words with at least 3 characters")
            return
        }
        guard isOriginal(word: answer) else {
            showError(title: "Word already used", message: "Be more original.")
            return
        }
        guard isPossible(word: answer) else {
            showError(title: "Word not recognized", message: "Please use only words with the letters.")
            return
        }
        guard isReal(word: answer) else {
            showError(title: "Word not recognized", message: "Please use only real words lol.")
            return
        }
        guard answer != rootWord else {
            showError(title: "Word already used", message: "Be more original. You are using the one on the title lol.")
            return
        }
        score += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }

    func showError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start file from Bundle")
    }
}

struct WordScramble_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView()
    }
}
