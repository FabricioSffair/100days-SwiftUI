//
//  ContentView.swift
//  BetterRest
//
//  Created by Fabricio Ssfair on 7/4/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI
import CoreML

struct BetterRestView: View {

    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    @State private var wakeUp: Date = defaultWakeupTime
    @State private var coffeeAmountString = 0
    @State private var sleepAmount = 8.0
    
    private var coffeeAmountArray = Array(0...20)
    private var coffeeAmount: Double {
        Double(self.coffeeAmountString)
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var idealBedTime = ""

    var body: some View {
        VStack {
            Form {
                Section() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How many hours would you like to sleep?")
                        Stepper(value: $sleepAmount, in: 4...18, step: 0.25) {
                            Text("\(String(format: "%g", sleepAmount)) Hours")
                        }
                    }
                }
                Section() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How many cups of coffee did you drink?")
                        Picker(selection: $coffeeAmountString, label: Text("How many cups of coffee did you drink?")) {
                            ForEach(0..<coffeeAmountArray.count) {
                                if $0 == 1 {
                                    Text("\(self.coffeeAmountArray[$0]) cup")
                                } else {
                                    Text("\(self.coffeeAmountArray[$0]) cups")
                                }
                            }
                        }
                        .labelsHidden()
                        // Stepper instead of Picker:
                        //                            Stepper(value: $coffeeAmount, in: 0...20, step: 0.5) {
                        //                                if coffeeAmount == 1 {
                        //                                    Text("\(String(format: "%g", coffeeAmount)) cup")
                        //                                } else {
                        //                                    Text("\(String(format: "%g", coffeeAmount)) cups")
                        //                                }
                        //                            }
                    }
                }
                Section() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What time do you wish to wake up?")
                        DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                Section(header: Text("Your ideal bedtime is:")) {
                    Text(calculateBedtime())
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .navigationBarTitle("Better Rest")
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: coffeeAmount)
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime. Please try again."
        }
    }
}

struct BetterRestView_Previews: PreviewProvider {
    static var previews: some View {
        BetterRestView()
    }
}
