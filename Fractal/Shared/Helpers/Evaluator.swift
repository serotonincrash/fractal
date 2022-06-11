//
//  Evaluator.swift
//  Fractal
//
//  Created by sen on 16/4/22.
//

import Foundation
import JavaScriptCore

class Evaluator {
    
    private let context: JSContext
    private var settings: EvaluatorSettings = EvaluatorSettings()
    
    func evalutate(expression: String) -> String {
        return ""
    }
    
    init() {
        self.context = JSContext()
        self.settings = EvaluatorSettings()
    }
    
    init(settings: EvaluatorSettings) {
        self.context = JSContext()
        self.settings = EvaluatorSettings()
    }
    
    
}
