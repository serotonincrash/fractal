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
    func sendCalcs(_ calcs: [Calculation])
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
        let angleMeasurementMode = UserDefaults.standard.string(forKey: "angleMeasurementMode") ?? "degrees"
        if angleMeasurementMode == "degrees" {
            evaluator.angleMeasurementMode = .degrees
        } else {
            evaluator.angleMeasurementMode = .radians
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func sendCalcs(_ calcs: [Calculation]) {
        calcTableViewController.updateCalcs(data: calcs)
    }
    func sendPressed(_ key: String) {
        currentButtonPressed = key
        if currentButtonPressed == "Settings" {
            performSegue(withIdentifier: "settingsSegue", sender: Any.self)
        } else {
            calcTableViewController.evalData(data: currentButtonPressed)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressHistoryButton(_ sender: Any) {
        performSegue(withIdentifier: "histSegue", sender: Any.self)
    }
    @IBAction func unwindToStart(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buttonsEmbed" {
            let dest = segue.destination as! CalcButtonsViewController
            calcButtonsViewController = dest
            dest.calcButtonDelegate = self
        } else if segue.identifier == "windowEmbed" {
            let dest = segue.destination as! CalcTableViewController
            calcTableViewController = dest
        } else if segue.identifier == "histSegue" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.viewControllers[0] as! CalcHistoryTableViewController
            dest.calculations = Calculation.loadFromFile() ?? []
        }
    }

}

