//
//  Calculations.swift
//  Fractal
//
//  Created by Sean on 1/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import Foundation
var evaluator = Evaluator()
// sig figs actually, but referred to as decimal places
var decimalPlaces: Int {
    get {
        if UserDefaults.standard.integer(forKey: "decimalPlaces") != 0 {
            return UserDefaults.standard.integer(forKey: "decimalPlaces")
        } else {
            return 15
        }
    } set {
        UserDefaults.standard.set(newValue, forKey: "decimalPlaces")
        UserDefaults.standard.synchronize()
    }
    
}
// angle measurement
var angleMeasurement: Evaluator.AngleMode {
    get {
        let str = UserDefaults.standard.string(forKey: "angleMeasurementMode") ?? ""
        if str == "" {
            return .degrees
        } else if str == "radians" {
            return .radians
        } else {
            return .degrees
        }
    } set {
        UserDefaults.standard.set(newValue, forKey: "angleMeasurementMode")
        UserDefaults.standard.synchronize()
    }
}

// Parsing function
func parseMath(calc: String, ans: String) -> String? {
    evaluator.angleMeasurementMode = angleMeasurement
    var result: Double = 0
    

    let subs = ["an": (ans)]
        do {
            result = try evaluator.evaluate(Expression(string: calc), substitutions: subs as Substitutions)
        } catch {
            let error = error as! MathParserError
            print(error.range)
         return "error"
        }
    if String(result) == "nan" {
        return "error"
    }
    if result > 10000000000 || (0 < result && result < 0.00000000001) || (0 > result && result < -0.00000000001)  {
        formatter.numberStyle = .scientific
        formatter.exponentSymbol = "×10^"
        formatter.maximumFractionDigits = decimalPlaces
        
    } else {
        let decimal = Decimal(string: String(result))
        print(decimal)
        if (decimal?.isWholeNumber)! {
            formatter.numberStyle = .none
        } else {
            // else we assume it's a normal decimal, irrational or whatever, and format it accordingly
            formatter.numberStyle = .decimal
            formatter.usesGroupingSeparator = false
            formatter.maximumFractionDigits = decimalPlaces
            
        }
    }
    return formatter.string(for: result)
}
let formatter = NumberFormatter()

// Round function
func round(number: Double, precision: Int) {
    return
}




