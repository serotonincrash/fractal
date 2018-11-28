//
//  Calculations.swift
//  Fractal
//
//  Created by Sean on 1/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import Foundation
var evaluator = Evaluator()
var decimalPlaces: Int {
    get {
        if UserDefaults.standard.integer(forKey: "decimalPlaces") != 0 {
            return UserDefaults.standard.integer(forKey: "decimalPlaces")
        } else {
            return 16
        }
    } set {
        UserDefaults.standard.set(newValue, forKey: "decimalPlaces")
        UserDefaults.standard.synchronize()
    }
    
}
// MARK: Parsing function
func parseMath(calc: String) -> String? {
    var result: Double = 0
    do {
        result = try evaluator.evaluate(Expression(string: calc))
    } catch {
        let error = error as! MathParserError
        print(error.range)
        return ""
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

