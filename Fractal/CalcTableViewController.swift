//
//  CalcTableViewController.swift
//  Fractal
//
//  Created by Sean on 6/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit
import ReverseExtension

class CalcTableViewController: UITableViewController {
    var calculations: [Calculation]! = Calculation.loadFromFile() ?? []
    var sessionCalculations = [Calculation(calc: "0", result: "　")]
    var ans: String = "0"
    var didDoMath: Bool = true
    var needsSpace = false
    var actualCalc = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.bounces = false
        evaluator.angleMeasurementMode = .degrees
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func evalData(data: String) {
        
        if true {
            if sessionCalculations[0].calc == "0" {
                didDoMath = true
            }
            if didDoMath {
                didDoMath = false
                switch data {
                case "=":
                    var result = parseMath(calc: actualCalc)
                    if result == "" || result == "nan" {
                        sessionCalculations[0].calc = "Error"
                        sessionCalculations[0].result = "　"
                        ans = "0"
                        self.tableView.reloadData()
                        sessionCalculations[0] = Calculation(calc: "0", result: "　")
                        actualCalc = "0"
                    } else if result! == "1.63312393531954e+16" {
                        sessionCalculations[0].result = "Number too large/Division by zero"
                        sessionCalculations[0].calc = "0"
                        ans = "0"
                        actualCalc = "0"
                        self.tableView.reloadData()
                    } else {
                        if Double(result!)!.truncatingRemainder(dividingBy: 1) == 0 {
                            result = String(Int(Double(result!)!))
                        }
                        sessionCalculations[0].result = sessionCalculations[0].calc
                        sessionCalculations[0].calc = String(Double(result!)!.truncate(places: 9))
                        actualCalc = String(result!)
                        ans = String(Double(result!)!)
                        didDoMath = false
                        self.tableView.reloadData()
                    }
                    
                    
                case "Del":
                    if sessionCalculations[0].calc.count == 1 {
                        if sessionCalculations[0].calc != "0" {
                            sessionCalculations[0] = Calculation(calc: "0", result: "　")
                            actualCalc = "0"
                            self.tableView.reloadData()
                        }
                    } else {
                        sessionCalculations[0].calc.removeLast()
                        actualCalc.removeLast()
                        self.tableView.reloadData()
                    }
                case "CA":
                    sessionCalculations[0] = Calculation(calc: "0", result: "　")
                    actualCalc = "0"
                    self.tableView.reloadData()
                case "CL":
                    sessionCalculations[0].calc = "0"
                    actualCalc = "0"
                    self.tableView.reloadData()
                case "Ans":
                    if ans == "0.0" || ans == "0" {
                        
                    } else if Double(ans)?.truncatingRemainder(dividingBy: 1) == 0 {
                        sessionCalculations[0].calc = "(" + String(Int(ans)!) + ")"
                        actualCalc = "(" + String(Int(ans)!) + ")"
                        self.tableView.reloadData()
                    } else {
                        sessionCalculations[0].calc = "(" + String(Double(ans)!.truncate(places: 9)) + ")"
                        actualCalc = "(" + String(Double(ans)!.truncate(places: 9)) + ")"
                        self.tableView.reloadData()
                    }
                case "log2(":
                    sessionCalculations[0].calc = "log₂("
                    actualCalc = "log2("
                    self.tableView.reloadData()
                case "e()":
                    sessionCalculations[0].calc = "e"
                    actualCalc = "e()"
                    self.tableView.reloadData()
                case "π()":
                    sessionCalculations[0].calc = "π"
                    actualCalc = "π()"
                    self.tableView.reloadData()
                default:
                    sessionCalculations[0].result = "　"
                    sessionCalculations[0].calc = data
                    actualCalc = data
                    self.tableView.reloadData()
                }
            } else {
                 switch data {
                 case "=":
                    didDoMath = true
                    var result = parseMath(calc: actualCalc)
                    var intResult = 0
                    print(result!)
                    if result == "" || result == "nan" {
                        sessionCalculations[0].result = "Error"
                        sessionCalculations[0].calc = "0"
                        ans = "0"
                        self.tableView.reloadData()
                    } else if result! == "1.63312393531954e+16" {
                        sessionCalculations[0].result = "Number too large/Division by zero"
                        sessionCalculations[0].calc = "0"
                        ans = "0"
                        actualCalc = "0"
                        self.tableView.reloadData()
                    } else {
                        if Double(result!)!.truncatingRemainder(dividingBy: 1) == 0 {
                            if let int = Double(result!) {
                                if int < Double(Int.max) {
                                    intResult = Int(int)
                                }
                            }
                        }
                        sessionCalculations[0].result = sessionCalculations[0].calc
                        if intResult != 0 {
                            sessionCalculations[0].calc = String(intResult)
                            actualCalc = String(intResult)
                            ans = String(intResult)
                            calculations.append(sessionCalculations[0])
                            self.tableView.reloadData()
                        } else {
                            sessionCalculations[0].calc = String(result!)
                            ans = String(result!)
                            actualCalc = String(result!)
                            calculations.append(sessionCalculations[0])
                            self.tableView.reloadData()
                        }
                        
                    }
                 case "Del":
                    if sessionCalculations[0].calc.count == 1 {
                        if sessionCalculations[0].calc != "0" {
                            sessionCalculations[0] = Calculation(calc: "0", result: "　")
                            actualCalc = "0"
                            self.tableView.reloadData()
                        }
                    } else {
                        sessionCalculations[0].calc.removeLast()
                        actualCalc.removeLast()
                        self.tableView.reloadData()
                    }
                 case "CA":
                    sessionCalculations[0] = Calculation(calc: "0", result: "　")
                    actualCalc = "0"
                    self.tableView.reloadData()
                 case "CL":
                    sessionCalculations[0].calc = "0"
                    actualCalc = "0"
                    self.tableView.reloadData()
                 case "Ans":
                    if ans == "0.0" || ans == "0" {
                        
                        self.tableView.reloadData()
                    } else if Double(ans)!.remainder(dividingBy: 1) == 0 {
                        sessionCalculations[0].calc = sessionCalculations[0].calc + "(" + String(Int(ans)!) + ")"
                        actualCalc = actualCalc + "(" + String(Int(ans)!) + ")"
                        self.tableView.reloadData()
                    } else {
                        sessionCalculations[0].calc = sessionCalculations[0].calc + "(" + String(Double(ans)!.truncate(places: 9)) + ")"
                        actualCalc = actualCalc + "(" + String(Double(ans)!.truncate(places: 9)) + ")"
                    }
                 case "e()":
                    sessionCalculations[0].calc = sessionCalculations[0].calc + "e"
                    actualCalc = actualCalc + "e()"
                    self.tableView.reloadData()
                 case "π()":
                    sessionCalculations[0].calc = sessionCalculations[0].calc + "π"
                    actualCalc = actualCalc + "π()"
                    self.tableView.reloadData()
                 case "log2(":
                    sessionCalculations[0].calc = sessionCalculations[0].calc + "log₂("
                    actualCalc = actualCalc + "log2("
                    self.tableView.reloadData()
                 default:
                        sessionCalculations[0].calc = sessionCalculations[0].calc + data
                        actualCalc = actualCalc + data
                        self.tableView.reloadData()
                }
            }
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sessionCalculations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calcCell", for: indexPath) as! CalculationTableViewCell
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "calcCell")
        //You can apply reverse effect only set delegate.
        tableView.re.delegate = self
        
        let calcCell = cell.calculationLabel
        let resultCell = cell.resultCell
            calcCell?.text = sessionCalculations[indexPath.row].result
            resultCell?.text = sessionCalculations[indexPath.row].calc
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}