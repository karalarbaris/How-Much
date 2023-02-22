//
//  TotalView.swift
//  How Much
//
//  Created by Baris Karalar on 22.02.23.
//

import SwiftUI

struct TotalView: View {
    let total: Double
    let tipPct: Int
    let numPeople: Int
    
    var tipAmount: Double {
        total * Double(tipPct) / 100
    }
    var totalAmount: Double {
        total + tipAmount
    }
    var portion: Double {
        totalAmount / Double(numPeople)
    }
    
    let identifier = Locale.current.currency?.identifier ?? ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Grid(horizontalSpacing: 20) {
                    GridRow {
                        Text("Original bill")
                            .gridColumnAlignment(.leading)
                        Text("\(total, format: .currency(code: identifier))")
                            .gridColumnAlignment(.trailing)
                    }
                    GridRow {
                        Text("Tip")
                            .gridColumnAlignment(.leading)
                        Text("\(tipAmount, format: .currency(code: identifier))")
                            .gridColumnAlignment(.trailing)
                    }
                    GridRow {
                        Text("Total")
                            .gridColumnAlignment(.leading)
                        Text("\(totalAmount, format: .currency(code: identifier))")
                            .gridColumnAlignment(.trailing)
                    }
                    GridRow {
                        Text("Portion")
                            .gridColumnAlignment(.leading)
                        Text("\(portion, format: .currency(code: identifier))")
                            .gridColumnAlignment(.trailing)
                    }
                }
                .font(.title)
                Image("myportion")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                Spacer()
            }
            .navigationTitle("Amount owing")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        TotalView(total: 120.5, tipPct: 10, numPeople: 3)
    }
}
