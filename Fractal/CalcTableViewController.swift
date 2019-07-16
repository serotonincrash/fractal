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
    var calculations: [Calculation]! = []
    var sessionCalculations = [Calculation(calc: "　", result: "　")]
    var ans: String = "0"
    var didDoMath: Bool = true
    var actualCalc = "0"
    let operationsWith3Chars = [" + "," - "," × "," ÷ ","ln(","$an"]
    let operationsWith3CharsNonSpaced = ["e()","π()"]
    let operationsWith4Chars = ["sin(","cos(","tan(","log(","exp("]
    let operationsWith5Chars = ["asin(","acos(","atan("," mod ","log2(","($an)"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.bounces = false
        Calculation.saveToFile(calcs: [])
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Actually adding the data to the UILabels
    
    func evalData(data: String) {
        if sessionCalculations[0].calc == "" || sessionCalculations[0].result == "" {
            
        }
        if didDoMath {
            didDoMath = false
            switch data {
            case "=":
                if actualCalc == "" {
                    actualCalc = "0"
                }
                var result = parseMath(calc: actualCalc, ans: ans)
                if result == "error" || result == "nan" {
                    sessionCalculations[0].result = "Error"
                    sessionCalculations[0].calc = "　"
                    ans = "0"
                    actualCalc = ""
                    self.tableView.reloadData()
                } else {
                        if result == "inf" {
                            sessionCalculations[0].calc = "Number too large"
                            sessionCalculations[0].result = "　"
                            ans = "0"
                            actualCalc = ""
                            self.tableView.reloadData()
                        } else {
                            if Decimal(string: result!)!.isWholeNumber {
                                sessionCalculations[0].result = sessionCalculations[0].calc
                                sessionCalculations[0].calc = String(result!)
                                actualCalc = String(result!)
                                ans = String(result!)
                                didDoMath = true
                                let temp = Calculation(calc: sessionCalculations[0].calc, result: sessionCalculations[0].result)
                                if let lastCalc = calculations.last {
                                    if !(lastCalc.calc == temp.calc && lastCalc.result == temp.result) {
                                        if !(temp.calc == "0" && temp.result == "　") {
                                            calculations.append(temp)
                                            print(calculations)
                                            Calculation.saveToFile(calcs: calculations)
                                        }
                                        
                                    }
                                } else {
                                    if !(temp.calc == "0" && temp.result == "　") {
                                        calculations.append(temp)
                                        print(calculations)
                                        Calculation.saveToFile(calcs: calculations)
                                        
                                    }
                                }
                            } else {
                                sessionCalculations[0].result = sessionCalculations[0].calc
                                sessionCalculations[0].calc = String(result!)
                                actualCalc = String(result!)
                                ans = String(result!)
                                didDoMath = true
                                let temp = Calculation(calc: sessionCalculations[0].calc, result: sessionCalculations[0].result)
                                if let lastCalc = calculations.last {
                                    if !(lastCalc.calc == temp.calc && lastCalc.result == temp.result) {
                                        if !(temp.calc == "0" && temp.result == "　") {
                                            calculations.append(temp)
                                            print(calculations)
                                            Calculation.saveToFile(calcs: calculations)
                                        }
                                    }
                                } else {
                                    if !(temp.calc == "0" && temp.result == "　") {
                                        calculations.append(temp)
                                        print(calculations)
                                        Calculation.saveToFile(calcs: calculations)
                                        
                                    }
                                    
                                }
                            }
                    }
                            

                    didDoMath = true
                    self.tableView.reloadData()
                }
            case "Del":
                if sessionCalculations[0].calc.count == 1 || actualCalc.count == 0 || sessionCalculations[0].calc.count == 0 || actualCalc.count == 1 {
                    if sessionCalculations[0].calc != "　" {
                        sessionCalculations[0] = Calculation(calc: "　", result: "　")
                        actualCalc = "0"
                        self.tableView.reloadData()
                    }
                } else if actualCalc.count == 1 {
                    sessionCalculations[0] = Calculation(calc: "　", result: "　")
                    actualCalc = "0"
                    self.tableView.reloadData()
                } else if actualCalc.count < 3 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if operationsWith3Chars.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 3 ..< actualCalc.count]
                }) {
                    sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 3])
                    actualCalc = String(actualCalc[0..<actualCalc.count - 3])
                    self.tableView.reloadData()
                } else if operationsWith3CharsNonSpaced.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 3 ..< actualCalc.count]
                }) {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc = String(actualCalc[0..<actualCalc.count - 3])
                    self.tableView.reloadData()
                } else if actualCalc.count < 4 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if operationsWith4Chars.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 4 ..< actualCalc.count]
                }) {
                    if actualCalc.count > 4 {
                        if operationsWith5Chars.contains(String(actualCalc[actualCalc.count - 5 ..< actualCalc.count])) {
                            sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 5])
                            actualCalc = String(actualCalc[0..<actualCalc.count - 5])
                            self.tableView.reloadData()
                        } else {
                            sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 4])
                            actualCalc = String(actualCalc[0..<actualCalc.count - 4])
                            self.tableView.reloadData()
                        }
                    } else {
                        sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 4])
                        actualCalc = String(actualCalc[0..<actualCalc.count - 4])
                        self.tableView.reloadData()
                    }
                    
                } else if actualCalc.count < 5 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if operationsWith5Chars.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 5 ..< actualCalc.count]
                }) {
                    sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 5])
                    actualCalc = String(actualCalc[0..<actualCalc.count - 5])
                    self.tableView.reloadData()
                } else if actualCalc.count < 6 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if String(actualCalc[actualCalc.count - 8 ..< actualCalc.count]) == "Random()" {
                    sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 8])
                    actualCalc = String(actualCalc[0..<actualCalc.count - 8])
                    self.tableView.reloadData()
                }  else if actualCalc.count < 9 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()		
                } else {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                }
            case "CA":
                sessionCalculations[0] = Calculation(calc: "　", result: "　")
                actualCalc = "0"
                self.tableView.reloadData()
            case "CL":
                sessionCalculations[0].calc = "　"
                actualCalc = "0"
                self.tableView.reloadData()
            case "Ans":
                if ans == "0.0" || ans == "0" {
                    
                } else if Double(ans)?.truncatingRemainder(dividingBy: 1) == 0 {
                    print("ans inserted")
                    sessionCalculations[0].calc = "Ans"
                    actualCalc = "$an"
                    self.tableView.reloadData()
                } else {
                    print("ans inserted")
                    sessionCalculations[0].calc = "Ans"
                    actualCalc = "$an"
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
            case " + ":
                sessionCalculations[0].calc = "Ans + "
                actualCalc = "$an + "
                self.tableView.reloadData()
            case " - ":
                sessionCalculations[0].calc = "Ans - "
                actualCalc = "$an - "
                self.tableView.reloadData()
            case " ÷ ":
                sessionCalculations[0].calc = "Ans ÷ "
                actualCalc = "$an ÷ "
                self.tableView.reloadData()
            case " × ":
                sessionCalculations[0].calc = "Ans × "
                actualCalc = "($an) × "
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
                if actualCalc == "" {
                    actualCalc = "0"
                }
                var result = parseMath(calc: actualCalc, ans: ans)
                if result == "error" || result == "nan" {
                    sessionCalculations[0].result = "Error"
                    sessionCalculations[0].calc = "　"
                    ans = "0"
                    actualCalc = ""
                    self.tableView.reloadData()
                } else {
                    if result == "inf" {
                        sessionCalculations[0].calc = "Number too large"
                        sessionCalculations[0].result = "　"
                        ans = "0"
                        actualCalc = ""
                        self.tableView.reloadData()
                    } else {
                        let decimal = Decimal(string: result!)
                        if decimal!.isWholeNumber {
                            sessionCalculations[0].result = sessionCalculations[0].calc
                            sessionCalculations[0].calc = String(result!)
                            actualCalc = String(result!)
                            ans = String(result!)
                            didDoMath = true
                            let temp = Calculation(calc: sessionCalculations[0].calc, result: sessionCalculations[0].result)
                            if let lastCalc = calculations.last {
                                if !(lastCalc.calc == temp.calc && lastCalc.result == temp.result) {
                                    if !(temp.calc == "0" && temp.result == "　") {
                                        calculations.append(temp)
                                        print(calculations)
                                        Calculation.saveToFile(calcs: calculations)
                                    }
                                    
                                }
                            } else {
                                if !(temp.calc == "0" && temp.result == "　") {
                                    calculations.append(temp)
                                    print(calculations)
                                    Calculation.saveToFile(calcs: calculations)
                                    
                                }
                            }
                        } else {
                            sessionCalculations[0].result = sessionCalculations[0].calc
                            sessionCalculations[0].calc = String(result!)
                            actualCalc = String(result!)
                            ans = String(result!)
                            didDoMath = true
                            let temp = Calculation(calc: sessionCalculations[0].calc, result: sessionCalculations[0].result)
                            if let lastCalc = calculations.last {
                                if !(lastCalc.calc == temp.calc && lastCalc.result == temp.result) {
                                    if !(temp.calc == "0" && temp.result == "　") {
                                        calculations.append(temp)
                                        print(calculations)
                                        Calculation.saveToFile(calcs: calculations)
                                    }
                                }
                            } else {
                                if !(temp.calc == "0" && temp.result == "　") {
                                    calculations.append(temp)
                                    print(calculations)
                                    Calculation.saveToFile(calcs: calculations)
                                    
                                }
                                
                            }
                        }
                    }
                    
                    
                    didDoMath = true
                    self.tableView.reloadData()
                }
             case "Del":
                if sessionCalculations[0].calc.count == 0 || actualCalc.count == 0 {
                    if sessionCalculations[0].calc != "　" {
                        sessionCalculations[0] = Calculation(calc: "　", result: "　")
                        actualCalc = "0"
                        self.tableView.reloadData()
                    }
                } else if actualCalc.count == 1 {
                    sessionCalculations[0] = Calculation(calc: "　", result: "　")
                    actualCalc = "0"
                    self.tableView.reloadData()
                } else if actualCalc.count < 3 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if operationsWith3Chars.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 3 ..< actualCalc.count]
                }) {
                    sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 3])
                    actualCalc = String(actualCalc[0..<actualCalc.count - 3])
                    self.tableView.reloadData()
                } else if operationsWith3CharsNonSpaced.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 3 ..< actualCalc.count]
                }) {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc = String(actualCalc[0..<actualCalc.count - 3])
                    self.tableView.reloadData()
                } else if actualCalc.count < 4 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if operationsWith4Chars.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 4 ..< actualCalc.count]
                }) {
                    if actualCalc.count > 4 {
                        if operationsWith5Chars.contains(String(actualCalc[actualCalc.count - 5 ..< actualCalc.count])) {
                            sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 5])
                            actualCalc = String(actualCalc[0..<actualCalc.count - 5])
                            self.tableView.reloadData()
                        } else {
                            sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 4])
                            actualCalc = String(actualCalc[0..<actualCalc.count - 4])
                            self.tableView.reloadData()
                        }
                    } else {
                        sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 4])
                        actualCalc = String(actualCalc[0..<actualCalc.count - 4])
                        self.tableView.reloadData()
                    }
                } else if actualCalc.count < 5 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if operationsWith5Chars.contains(where: { (str) -> Bool in
                    str == self.actualCalc[actualCalc.count - 5 ..< actualCalc.count]
                }) {
                    sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 5])
                    actualCalc = String(actualCalc[0..<actualCalc.count - 5])
                    self.tableView.reloadData()
                } else if actualCalc.count < 8 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else if String(actualCalc[actualCalc.count - 8 ..< actualCalc.count]) == "Random()" {
                    sessionCalculations[0].calc = String(sessionCalculations[0].calc[0 ..< sessionCalculations[0].calc.count - 8])
                    actualCalc = String(actualCalc[0..<actualCalc.count - 8])
                    self.tableView.reloadData()
                } else if actualCalc.count < 9 {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                } else {
                    sessionCalculations[0].calc.removeLast()
                    actualCalc.removeLast()
                    self.tableView.reloadData()
                }
             case "CA":
                sessionCalculations[0] = Calculation(calc: "　", result: "　")
                actualCalc = "0"
                self.tableView.reloadData()
             case "CL":
                sessionCalculations[0].calc = "　"
                actualCalc = "0"
                self.tableView.reloadData()
             case "Ans":
                print(ans)
                if ans == "0.0" || ans == "0" {
                    
                } else {
                    if actualCalc == "0" {
                        sessionCalculations[0].calc = "Ans"
                        actualCalc = "$an"
                        self.tableView.reloadData()
                    } else {
                            sessionCalculations[0].calc = sessionCalculations[0].calc + "Ans"
                            actualCalc = actualCalc + "$an"
                            self.tableView.reloadData()
                    }
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
                if actualCalc != "0" {
                    sessionCalculations[0].calc = sessionCalculations[0].calc + data
                    actualCalc = actualCalc + data
                    self.tableView.reloadData()
                } else {
                    sessionCalculations[0].calc = sessionCalculations[0].calc + data
                    actualCalc = data
                    self.tableView.reloadData()		
                }
            }
        }
        self.tableView.reloadData()
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
        let resultCell = cell.resultLabel
        calcCell?.text = sessionCalculations[indexPath.row].result
        resultCell?.text = sessionCalculations[indexPath.row].calc
        // Configure the cell...

        return cell
    }
    func updateCalcs(data: [Calculation]) {
        calculations = data
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
