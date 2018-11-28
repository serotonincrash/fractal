//
//  Calculations.swift
//  Fractal
//
//  Created by Sean on 1/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import Foundation
var calc = ""
var evaluator = Evaluator()
var angleMode: Evaluator.AngleMode = .degrees
let power = Operator(builtInOperator: .power)
let operatorset = OperatorSet()
func roundToPlaces(value:Double, places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
}
class Calculation: Encodable, Decodable {
    var calc: String
    var result: String
    init(calc: String, result: String) {
        self.calc = calc
        self.result = result
    }
    static func getArchiveURL() -> URL {
        let plistName = "calculations"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(calcs: [Calculation]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedCalcs = try? propertyListEncoder.encode(calcs)
        try? encodedCalcs?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Calculation]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedCalcsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedCalcs = try? propertyListDecoder.decode(Array<Calculation>.self, from: retrievedCalcsData) else { return nil }
        return decodedCalcs
    }
}
extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
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
    if (result.truncatingRemainder(dividingBy: 1) < 0.00000000001 || result.truncatingRemainder(dividingBy: 1) > 0.9999999999) && result < Double(Int.max){
        return (String(Int(round(result))))
    } else {
        return String(roundToPlaces(value: result, places: 16))
    }
}

