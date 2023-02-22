//
//  ContentView.swift
//  How Much
//
//  Created by Baris Karalar on 21.02.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("tipPct") var tipPct = 0
    @State private var numPeople = 1
    @State private var total = "0"
    @State private var calculate = false
    
    
    
    var canAddDecimal: Bool {
        total.contains(decChar) ? false : true
        //        total.filter({$0 == "."}).count == 0 ? true : false
    }
    
    var canAddDigit: Bool {
        guard let decIndex = total.firstIndex(of: decChar) else { return true}
        let index = total.distance(from: total.startIndex, to: decIndex)
        return total.count - index - 1 < 2
    }
    
    let decChar = Character(Locale.current.decimalSeparator ?? ".")
    
    var contentView: some View {
        VStack {
            Text(total)
                .font(.system(size: 70))
                .frame(width: 240 + 20, alignment: .trailing)
                .padding(.vertical, 1)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            HStack {
                ForEach(1...3, id: \.self) { num in
                    numberButton(number: "\(num)")
                }
            }
            HStack {
                ForEach(4...6, id: \.self) { num in
                    numberButton(number: "\(num)")
                }
            }
            HStack {
                ForEach(7...9, id: \.self) { num in
                    numberButton(number: "\(num)")
                }
            }
            HStack {
                numberButton(number: "0")
                numberButton(number: String(decChar))
                Button {
                    if total.count == 1 {
                        total = "0"
                    } else {
                        total.removeLast()
                    }
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .font(.largeTitle)
                        .bold()
                        .frame(width: 80, height: 80)
                        .background {
                            Color.gray
                        }
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            HStack{
                Text("Tip")
                Picker(selection: $tipPct, label: Text("Tip")) {
                    ForEach(0...100, id: \.self) { tip in
                        Text("\(tip)%")
                    }
                }
                .buttonStyle(.bordered)
            }
            HStack{
                Text("Number of people")
                Picker(selection: $numPeople, label: Text("Number of people")) {
                    ForEach(1...20, id: \.self) { numPeople in
                        Text("\(numPeople)")
                    }
                }
                .buttonStyle(.bordered)
            }
            HStack {
                Button("Calculate") {
                    calculate = true
                }
                .sheet(isPresented: $calculate) {
                    TotalView(total: Double(total) ?? 0, tipPct: tipPct, numPeople: numPeople)
                        .presentationDetents([.medium])
                }
                Button("Clear") {
                    total = "0"
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(Double(total) == 0)
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ViewThatFits {
                contentView
                ScrollView {
                    contentView
                }
            }
            Spacer()
                .navigationTitle("Portion Calculator")
        }
        
    }
    
    func addDigit(_ number: String) {
        if canAddDigit {
            if number == String(decChar) {
                if canAddDecimal {
                    total += number
                }
            } else {
                total = total == "0" ? number : total + number
            }
        }
    }
    
    
    func numberButton(number: String) -> some View {
        Button {
            addDigit(number)
        } label: {
            Text(number)
                .font(.largeTitle)
                .bold()
                .frame(width: 80, height: 80)
                .background {
                    Color.purple
                }
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .tint(.purple)
    }
}
