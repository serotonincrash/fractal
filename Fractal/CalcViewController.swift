//
//  ViewController.swift
//  Fractal
//
//  Created by Sean on 1/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

protocol CalcButtonDelegate: AnyObject {
    func sendPressed(_ key: String)
}

class CalcViewController: UIViewController, CalcButtonDelegate {
    @IBOutlet weak var calcWindowContainerView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    var currentOperationNeedsSpace: Bool = false
    var currentButtonPressed: String = ""
    var calcButtonsViewController: CalcButtonsViewController!
    var calcTableViewController: CalcTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func sendPressed(_ key: String) {
        currentButtonPressed = key
        calcTableViewController.evalData(data: currentButtonPressed)
    }
    
//    private lazy var CalcButtonsViewController: CalcButtonsViewController = {
//        // Load Storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//        // Instantiate View Controller
//        var viewController = storyboard.instantiateViewController(withIdentifier: "ButtonsViewController") as! CalcButtonsViewController
//        viewController.calcButtonDelegate = self
//        // Add View Controller as Child View Controller
//
//        return viewController
//    }()
//    private lazy var CalcTableViewController: CalcTableViewController = {
//        // Load Storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//        // Instantiate View Controller
//        var viewController = storyboard.instantiateViewController(withIdentifier: "CalcWindowViewController") as! CalcTableViewController
//
//        // Add View Controller as Child View Controller
//
//
//        return viewController
//    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buttonsEmbed" {
            let dest = segue.destination as! CalcButtonsViewController
            calcButtonsViewController = dest
            dest.calcButtonDelegate = self
        } else if segue.identifier == "windowEmbed" {
            let dest = segue.destination as! CalcTableViewController
            calcTableViewController = dest
        }
    }

}

