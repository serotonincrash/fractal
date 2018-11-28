//
//  ButtonsPage2.swift
//  Fractal
//
//  Created by Sean on 28/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

class ButtonsPage2: UIViewController {
    var currentButtonPressed = ""
    var calcButtonDelegate: CalcButtonDelegate?
    let impact = UIImpactFeedbackGenerator()
    @IBAction func buttonPressed(_ sender: CustomButton) {
        sender.blinkstart()
        impact.impactOccurred()
    }
    @IBAction func buttonDragged(_ sender: CustomButton) {
        sender.blinkend()
    }
    @IBAction func buttonReleased(_ sender: CustomButton) {
        sender.blinkend()
        switch (sender.titleLabel?.text)! {
        case "n!":
            currentButtonPressed = "!"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "ln":
            currentButtonPressed = "ln("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "aⁿ":
            currentButtonPressed = "^"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "a²":
            currentButtonPressed = "^2"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "a⁻¹":
            currentButtonPressed = "^-1"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "mod":
            currentButtonPressed = " mod "
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "=":
            currentButtonPressed = "="
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "eⁿ":
            currentButtonPressed = "exp("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "10ⁿ":
            currentButtonPressed = "10^"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case ",":
            currentButtonPressed = ","
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "CA":
            currentButtonPressed = "CA"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "atan":
            currentButtonPressed = "atan("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "asin":
            currentButtonPressed = "asin("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "acos":
            currentButtonPressed = "acos("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "sin":
            currentButtonPressed = "sin("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "cos":
            currentButtonPressed = "cos("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "tan":
            currentButtonPressed = "tan("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "CL":
            currentButtonPressed = "CL"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "π":
            currentButtonPressed = "π()"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "e":
            currentButtonPressed = "e()"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "log":
            currentButtonPressed = "log("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "log₂":
            currentButtonPressed = "log2("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "Del":
            currentButtonPressed = "Del"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "Rand":
            currentButtonPressed = "Random()"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "Settings":
            currentButtonPressed = "Settings"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "∛":
            currentButtonPressed = "∛"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        default:
            print("default")
        }
    }
    override func viewDidLoad() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
