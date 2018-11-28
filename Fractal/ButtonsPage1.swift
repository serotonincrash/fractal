//
//  ButtonsPage1.swift
//  Fractal
//
//  Created by Sean on 28/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

class ButtonsPage1: UIViewController {
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
        switch (sender.titleLabel?.text!)! {
        case "√a":
            currentButtonPressed = "√"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "(":
            currentButtonPressed = "("
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case ")":
            currentButtonPressed = ")"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "Ans":
            currentButtonPressed = "Ans"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "Del":
            currentButtonPressed = "Del"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "1":
            currentButtonPressed = "1"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "2":
            currentButtonPressed = "2"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "3":
            currentButtonPressed = "3"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "×":
            currentButtonPressed = " × "
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "÷":
            currentButtonPressed = " ÷ "
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "4":
            currentButtonPressed = "4"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "5":
            currentButtonPressed = "5"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "6":
            currentButtonPressed = "6"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "+":
            currentButtonPressed = " + "
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "-":
            currentButtonPressed = " - "
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "7":
            currentButtonPressed = "7"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "8":
            currentButtonPressed = "8"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "9":
            currentButtonPressed = "9"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "CA":
            currentButtonPressed = "CA"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "%":
            currentButtonPressed = "%"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "0":
            currentButtonPressed = "0"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case ".":
            currentButtonPressed = "."
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "×10ⁿ":
            currentButtonPressed = "×10^"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "=":
            currentButtonPressed = "="
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        default:
            print()
        }
    }
    
    override func viewDidLoad() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
