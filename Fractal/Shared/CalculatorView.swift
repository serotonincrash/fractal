//
//  CalculatorView.swift
//  Shared
//
//  Created by sen on 8/4/22.
//

import SwiftUI

struct CalculatorView: View {
    @State var calc: String
    var ans: Double
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { metrics in
                    VStack {
                        VStack(spacing:0) {
                            Text("Result goes here")
                                .lineLimit(1)
                                .frame(width: metrics.size.width, height: metrics.size.height / 25, alignment: .bottomLeading)
                                .font(.system(size:24))
                            ScrollView(.horizontal) {
                                Text(calc)
                                    .lineLimit(2)
                                    .font(.system(size:32))

                            }
                            .frame(width: metrics.size.width, height: metrics.size.height / 18, alignment: .bottomLeading)
                        }
                        HStack(alignment: .bottom, spacing: 0) {
                            CalcButton(text: "Tets", inputString: "test", labelText: $calc)
                                .frame(width: metrics.size.width / 5, height: metrics.size.width / 5, alignment: .center)
                            CalcButton(text: "Tets", inputString: "test", labelText: $calc)
                                .frame(width: metrics.size.width / 5, height: metrics.size.width / 5, alignment: .center)
                            CalcButton(text: "Tets", inputString: "test", labelText: $calc)
                                .frame(width: metrics.size.width / 5, height: metrics.size.width / 5, alignment: .center)
                            CalcButton(text: "Tets", inputString: "test", labelText: $calc)
                                .frame(width: metrics.size.width / 5, height: metrics.size.width / 5, alignment: .center)
                            CalcButton(text: "Tets", inputString: "test", labelText: $calc)
                                .frame(width: metrics.size.width / 5, height: metrics.size.width / 5, alignment: .center)

                        }
                    }
                    
                }
                .padding()
        }
        
        

            
    }
        
    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView(calc: "Calculation goes here", ans: 0.0)
        }
            
    }
}

