//
//  ContentView.swift
//  WeSplit
//
//  Created by Maks Winters on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total: Double {
        var tip = checkAmount / 100 * Double(tipPercentage)
        return checkAmount + tip
    }
    
    var totalForEach: Double {
        var tip = checkAmount / 100 * Double(tipPercentage)
        return (checkAmount + tip) / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter data:") {
                    TextField("💳 Enter check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Stepper("Number of people: \(numberOfPeople)", value: $numberOfPeople, in: 2...100)
                }
                Section("Leave a tip:") {
                    Picker("Tip:", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total:") {
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total for each person:") {
                    Text(totalForEach, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
