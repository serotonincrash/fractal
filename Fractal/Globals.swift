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
    var result: Double = 0
    let subs = ["an": Double(ans)]
    do {
        result = try evaluator.evaluate(Expression(string: calc), substitutions: subs as! Substitutions)
    } catch {
        let error = error as! MathParserError
        print(error.range)
        return "error"
    }
    print(result.truncatingRemainder(dividingBy: 1))
    print(calc.count)
    print(String(result).count)
    if (result.truncatingRemainder(dividingBy: 1) < 0.00000000001 || result.truncatingRemainder(dividingBy: 1) > 0.9999999999) && result < Double(Int.max){
        return (String(Int(round(result))))
    } else {
        return String(result.roundToDecimal(decimalPlaces))
    }
}


