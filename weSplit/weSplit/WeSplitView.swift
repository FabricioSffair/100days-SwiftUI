//
//  ContentView.swift
//  weSplit
//
//  Created by Fabrício Sperotto Sffair on 2020-06-29.
//  Copyright © 2020 Fabrício Sperotto Sffair. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var numOfPeople = "2"
    @State private var billAmount = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 18, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Bill Amount?", text: $billAmount)
                        .keyboardType(.decimalPad)
                        
                    TextField("Number of people splitting the bill?", text: $numOfPeople)
                        .keyboardType(.numberPad)
                        .onReceive(Just(numOfPeople)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue { self.numOfPeople = filtered }
                        }
                }
                Section(header: Text("Select Tip %:")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text(self.calculateAmountPerPerson())
                }
            }
            .navigationBarTitle(Text("We SplitSwift UI"))
        }
    }
    
    func calculateAmountPerPerson() -> String {
        guard let amount = Double(billAmount),
                let numOfPeople = Double(self.numOfPeople)
                else { return "$" }
        let totalAmount = amount + (amount / 100 * Double(tipPercentages[tipPercentage]))
        let amountPerPerson = String(format: "%.2f", (totalAmount / numOfPeople))
        return "$ \(amountPerPerson)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
