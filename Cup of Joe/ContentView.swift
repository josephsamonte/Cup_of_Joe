//
//  ContentView.swift
//  Cup of Joe
//
//  Created by Joseph Samonte on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var coffeeAmount: String = ""
    @State private var waterRatio: Double = 15
    @State private var waterAmount: Double = 0
    
    let ratioOptions = ["Strong 🌋", "Medium 🏔", "Weak 🏖"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Coffee")) {
                    TextField("Enter amount in grams", text: $coffeeAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Water Ratio")) {
                    Picker(selection: $waterRatio, label: Text("Select Ratio")) {
                        ForEach([15.0, 16.0, 17.0], id: \.self) { ratio in
                            let index = Int(ratio) - 15
                            Text(ratioOptions[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(Int(waterRatio)):1 Ratio")
                    Text("\(waterAmount, specifier: "%.2f") ml water / \(coffeeAmount) g coffee")
                }
            }
            .navigationBarTitle("Pour Over Ratio")
            .background(Color("LightBrown"))
        }
        .onChange(of: coffeeAmount) { newValue in
            calculateWaterAmount()
        }
        .onChange(of: waterRatio) { newValue in
            calculateWaterAmount()
        }
    }
    
    private func calculateWaterAmount() {
        guard let coffeeAmount = Double(coffeeAmount) else {
            return
        }
        
        waterAmount = coffeeAmount * waterRatio
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
