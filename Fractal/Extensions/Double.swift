//
//  Double.swift
//  DDMathParser
//
//  Created by Dave DeLong on 9/5/15.
//
//

import Foundation

internal extension Int {
    
    static let largestSupportedIntegerFactorial: Int = {
        var n = Int.max
        var i = 2
        while i < n {
            n /= i
            i += 1
        }
        return i - 1
    }()
    
}

internal extension Double {
    
    func factorial() -> Double {
        if Darwin.floor(self) == self && self > 1 {
            // it's a factorial of an integer
            
            if self <= Double(Int.largestSupportedIntegerFactorial) {
                // it's a factorial of an integer representable as an Int
                let arg1Int = Int(self)
                return Double((1...arg1Int).reduce(1, *))
            } else if self <= Double(Int.max) {
                // it's a factorial of an integer NOT representable as an Int
                var result = 1.0
                for i in 2 ... Int(self) {
                    result *= Double(i)
                }
                return result
            }
        }
        return tgamma(self+1)
    }
    
    // Fractal: Handling Doubles
    
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        return Double(String(format: "%.\(fractionDigits)f", self))!
    }
    func getDecimal() -> Double {
        return self.truncatingRemainder(dividingBy: 1)
    }
    func toString(decimal: Int = 9) -> String {
        let value = decimal < 0 ? 0 : decimal
        var string = String(format: "%.\(value)f", self)
        
        while string.last == "0" || string.last == "." {
            if string.last == "." { string = String(string.dropLast()); break}
            string = String(string.dropLast())
        }
        return string
    }
}
internal extension Decimal {
    func toString(decimal: Int = 9) -> String {
        let value = decimal < 0 ? 0 : decimal
        var string = String(format: "%.\(value)f", self as CVarArg)
        
        while string.last == "0" || string.last == "." {
            if string.last == "." { string = String(string.dropLast()); break}
            string = String(string.dropLast())
        }
        return string
    }
    var isWholeNumber: Bool {
        if isZero { return true }
        if !isNormal { return false }
        var myself = self
        var rounded = Decimal()
        NSDecimalRound(&rounded, &myself, 0, .plain)
        return self == rounded
    }
}
