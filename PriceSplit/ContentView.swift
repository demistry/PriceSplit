//
//  ContentView.swift
//  PriceSplit
//
//  Created by David Ilenwabor on 09/10/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    private var isZeroTipSelected : Bool{
        return tipPercentage == 4
    }
    
    private var splitAmount : Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let amountDouble = Double(checkAmount) ?? 0.0
        let totalAmount = (tipSelection * amountDouble/100) + amountDouble
        return totalAmount / peopleCount
    }
    
    private var totalAmount : Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let amountDouble = Double(checkAmount) ?? 0.0
        return (tipSelection * amountDouble/100) + amountDouble
    }
    
    let tipPercentages = [10,15,20,25,0]
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2 ..< 100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header : Text("How much tip do you want to leave?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header : Text("Total amount to be paid")){
                    Text("$\(totalAmount, specifier : "%.2f")")
                        .foregroundColor(self.isZeroTipSelected ? .red : .black)
                }
                Section(header : Text("Amount per person")){
                    Text("$\(splitAmount, specifier: "%.2f")")
                }
                
                
            }.navigationBarTitle("Price Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
