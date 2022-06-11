//
//  EvaluatorSettings.swift
//  Fractal
//
//  Created by sen on 16/4/22.
//

import Foundation

struct EvaluatorSettings {
    var significantFigures: Int
    
    var angleExpression: AngleExpression
    
    init() {
        // default stuff
        self.significantFigures = 9
        self.angleExpression = .degrees
    }
}
enum AngleExpression {
    case radians
    case degrees
}
