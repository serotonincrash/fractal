//
//  CalcButtonsViewController.swift
//  Fractal
//
//  Created by Sean on 3/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

class CalcButtonsViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var calcButtonDelegate: CalcButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let firstViewController = orderedViewControllers.first,
            let viewController = firstViewController as? ButtonsPage1 {
            let viewController2 = orderedViewControllers[1] as? ButtonsPage2
            viewController2?.calcButtonDelegate = calcButtonDelegate
            viewController.calcButtonDelegate = calcButtonDelegate
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPage(number: "1"),
                self.newPage(number: "2")]
    }()
    private func newPage(number: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "page\(number)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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
            currentButtonPressed = "×"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "÷":
            currentButtonPressed = "÷"
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
            currentButtonPressed = "+"
            calcButtonDelegate?.sendPressed(currentButtonPressed)
        case "-":
            currentButtonPressed = "-"
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
            currentButtonPressed = "mod"
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
class ButtonsPage3: UIViewController {
    override func viewDidLoad() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
