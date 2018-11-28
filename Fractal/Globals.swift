//
//  Calculations.swift
//  Fractal
//
//  Created by Sean on 1/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import Foundation
var evaluator = Evaluator()
func roundToPlaces(value:Double, places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
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
    if (result.truncatingRemainder(dividingBy: 1) < 0.00000000001 || result.truncatingRemainder(dividingBy: 1) > 0.9999999999) && result < Double(Int.max){
        return (String(Int(round(result))))
    } else {
        return String(roundToPlaces(value: result, places: 16))
    }
}

