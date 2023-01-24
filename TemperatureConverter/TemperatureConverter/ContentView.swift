//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Matt Goodhart on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    @State var inputNumber = 20.0
    @State var inputUnit = "Kelvin"
    @State var outputUnit = "Celcius"
    
    let unitTypes: [String] = ["Kelvin", "Celcius", "Fahrenheit"]
    
    var toKelvin: Double {
        var convertedNumber: Double = inputNumber
        
        if inputUnit == "Kelvin" {
            return inputNumber
        }
        else if inputUnit == "Celcius" {
            convertedNumber = 273.15 + inputNumber
        } else if
            inputUnit == "Fahrenheit" {
            convertedNumber = (inputNumber - 32) * 5/9 + 273.15
        }
        return convertedNumber
    }
    
    var outputNumber: Double {
        var convertedNumber: Double = inputNumber
        
        if outputUnit == "Kelvin" {
            return toKelvin
        }
        else if outputUnit == "Celcius" {
            convertedNumber = toKelvin - 273.15
            
        } else  if outputUnit == "Fahrenheit" {
            convertedNumber = (toKelvin - 273.15) * 9/5 + 32
        }
        return convertedNumber
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit to Convert From", selection: $inputUnit) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                header: {
                Text("Unit to Convert")
                }
                Section {
                    TextField("yo", value: $inputNumber, format: .number)
                }
                header: {
                Text("Enter Value")
                }
                Section {
                    Picker("Unit to Convert From", selection: $outputUnit) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                header: {
                Text("Covert To")
                }
                Section {
                    Text(outputNumber, format: .number)
                }
                header: {
                Text("Output")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
