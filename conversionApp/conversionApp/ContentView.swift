//
//  ContentView.swift
//  conversionApp
//
//  Created by Fabricio Ssfair on 6/30/20.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

enum Unit: Int, Hashable, CaseIterable, Identifiable {
    case temperature = 0, length, time, volume
    var displayValue: String {
        "\(self)".capitalized
    }
    var id: Unit { self }
    var units: [String] {
        switch self {
        case .time:
            return TimeUnit.allCases.map { $0.displayValue }
        case .length:
            return LengthUnit.allCases.map { $0.displayValue }
        case .volume:
            return VolumeUnit.allCases.map { $0.displayValue }
        case .temperature:
            return TemperatureUnit.allCases.map { $0.displayValue }
        }
    }
}

enum TemperatureUnit: Int, Identifiable, CaseIterable {
    case celsius, fahrenheit, kelvin
    var displayValue: String {
        "\(self)".capitalized
    }
    var id: TemperatureUnit { self }
    
    func toCelsius(amount: Double) -> Double {
        switch self {
        case .celsius:
            return amount
        case .fahrenheit:
            return (amount - 32) * 5 / 9
        case .kelvin:
            return amount - 273.15
        }
    }
    
    func convert(from value: Double, to unit: TemperatureUnit) -> Double {
        let amount = toCelsius(amount: value)
        switch unit {
        case .celsius:
            return amount
        case .fahrenheit:
            return amount * 9/5 + 32
        case .kelvin:
            return amount + 273.15
        }
    }
}

enum LengthUnit: Int, Identifiable, CaseIterable {
    case meters, feet, yard, mile
    var displayValue: String {
        "\(self)".capitalized
    }
    var id: LengthUnit { self }
    
    private func toFeet(amount: Double) -> Double {
        switch self {
        case .feet:
            return amount
        case .meters:
            return amount * 3.281
        case .yard:
            return amount * 3
        case .mile:
            return amount * 5280
        }
    }
    
    func convert(from value: Double, to unit: LengthUnit) -> Double {
        let amount = toFeet(amount: value)
        switch unit {
        case .feet:
             return amount
         case .meters:
             return amount / 3.281
         case .yard:
             return amount / 3
         case .mile:
             return amount / 5280
        }
    }
}

enum TimeUnit: Int, CaseIterable {
    case seconds, minutes, hours, days
    var displayValue: String {
        "\(self)".capitalized
    }
    private func toSeconds(amount: Double) -> Double {
        switch self {
        case .seconds:
            return amount
        case .minutes:
            return amount * 60
        case .hours:
            return amount * 60 * 60
        case .days:
            return amount * 60 * 60 * 24
        }
    }
    
    func convert(from value: Double, to unit: TimeUnit) -> Double {
        let amount = toSeconds(amount: value)
        switch unit {
        case .seconds:
            return amount
        case .minutes:
            return amount / 60
        case .hours:
            return amount / 60 / 60
        case .days:
            return amount / 60 / 60 / 24
        }
    }
}

enum VolumeUnit: Int, CaseIterable {
    case mililiters, liters, cups, pints, gallons
    var displayValue: String {
        "\(self)".capitalized
    }
    private func toMililiters(amount: Double) -> Double {
        switch self {
        case .mililiters:
            return amount
        case .liters:
            return amount * 1000
        case .cups:
            return amount * 236.588
        case .pints:
            return amount * 473.176
        case .gallons:
            return amount * 3785.41
        }
    }
    
    func convert(from value: Double, to unit: VolumeUnit) -> Double {
        let amount = toMililiters(amount: value)
        switch unit {
        case .mililiters:
            return amount
        case .liters:
            return amount / 1000
        case .cups:
            return amount / 236.588
        case .pints:
            return amount / 473.176
        case .gallons:
            return amount / 3785.41
        }
    }
}

struct ContentView: View {
    
    @State private var selectedUnit = Unit.volume {
        willSet {
            convertFromUnit = 0
        }
    }
    @State private var convertFromUnit = 0
    @State private var convertToUnit = 0
    @State private var convertInput: String = ""
    private var convertFromValue: Double {
        guard let input = Double(convertInput) else { return 0.0 }
        return input
    }
    
    var conversionResultString: String {
        String(format: "%.2f", conversionResult)
    }
    
    var conversionResult: Double {
        switch selectedUnit {
        case .temperature:
            guard let finalUnit = TemperatureUnit(rawValue: convertToUnit),
                let convertedAmount = TemperatureUnit(rawValue: convertFromUnit)?.convert(from: convertFromValue, to: finalUnit) else { return 0.0 }
            return convertedAmount
        case .time:
            guard let finalUnit = TimeUnit(rawValue: convertToUnit),
                let convertedAmount = TimeUnit(rawValue: convertFromUnit)?.convert(from: convertFromValue, to: finalUnit) else { return 0.0 }
            return convertedAmount
        case .length:
            guard let finalUnit = LengthUnit(rawValue: convertToUnit),
                let convertedAmount = LengthUnit(rawValue: convertFromUnit)?.convert(from: convertFromValue, to: finalUnit) else { return 0.0 }
            return convertedAmount
        case .volume:
            guard let finalUnit = VolumeUnit(rawValue: convertToUnit),
                let convertedAmount = VolumeUnit(rawValue: convertFromUnit)?.convert(from: convertFromValue, to: finalUnit) else { return 0.0 }
            return convertedAmount
        }
    }
    
    var body: some View {
        let binding = Binding(get: { self.selectedUnit },
                              set: {
                                self.convertFromUnit = 0
                                self.convertToUnit = 0
                                self.selectedUnit = $0
                            })
        return NavigationView {
            Form {
                Section(header: Text("Select conversion type:")) {
                    Picker("Select Unit Conversion option", selection: binding) {
                        ForEach(Unit.allCases) { unit in
                            Text(unit.displayValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert from:")) {
                    TextField("0.0", text: $convertInput)
                    Picker(selection: self.$convertFromUnit, label: Text("From")) {
                        ForEach(0..<self.selectedUnit.units.count) {
                            Text("\(self.selectedUnit.units[$0])").tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Convert To:")) {
                    Picker(selection: self.$convertToUnit, label: Text("From")) {
                        ForEach(0..<self.selectedUnit.units.count) {
                            Text("\(self.selectedUnit.units[$0])").tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Text(conversionResultString)
            }
        .navigationBarTitle("Convert it!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
