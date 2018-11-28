//
//  CalcHistoryTableViewController.swift
//  Fractal
//
//  Created by Sean on 10/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

class CalcHistoryTableViewController: UITableViewController {
    var calculations: [Calculation]! = []
    var CalcViewDelegate: CalcButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGray
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return calculations.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CalculationTableViewCell
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
            let transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            cell.resultLabel.transform = transform
            cell.calculationLabel.transform = transform
            cell.copiedLabel.alpha = 1.0
        })
        animator.addCompletion { (_) in
            let animation = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
                cell.resultLabel.transform = CGAffineTransform.identity
                cell.calculationLabel.transform = CGAffineTransform.identity
                cell.copiedLabel.alpha = 0
            })
            animation.startAnimation()
        }
        animator.startAnimation()
        UIPasteboard.general.string = cell.calculationLabel.text! + " = " + cell.resultLabel.text!
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histCell", for: indexPath) as! CalculationTableViewCell
            cell.calculationLabel.text = self.calculations[indexPath.row].result
            cell.resultLabel.text = self.calculations[indexPath.row].calc
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
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            calculations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Calculation.saveToFile(calcs: calculations)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let calc = calculations.remove(at: sourceIndexPath.row)
        calculations.insert(calc,at: destinationIndexPath.row)
        Calculation.saveToFile(calcs: calculations)
        tableView.reloadData()
    }

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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "unwindSegue" {
            let dest = segue.destination as! CalcViewController
            dest.sendCalcs(calculations)
        }
    }


}
