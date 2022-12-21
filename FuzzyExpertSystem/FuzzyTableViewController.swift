//
//  FuzzyTableViewController.swift
//  FuzzyExpertSystem
//
//  Created by Georgy on 18.12.2022.
//

import UIKit
import RealmSwift
class FuzzyTableViewController: UITableViewController {
    let realm = try! Realm(configuration: .init(schemaVersion: 3))
    let changes = try! Realm().objects(VaritivesChanges.self)
    let variative1 = try! Realm().objects(Variative1.self)
    let variative2 = try! Realm().objects(Variative2.self)
    let variative3 = try! Realm().objects(Variative3.self)
    let resactiv = try! Realm().objects(VariativeActiv.self)
    var msg = ""
    var resaggr = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    var aggrrules = [0.0,0.0,0.0]
    var resaccum = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]

    func ShowAlert(){
        let alert = UIAlertController(title: "Result", message: msg, preferredStyle: .alert)
        let OkButton = UIAlertAction(title: "Ok", style: .default)
            let noBtn =  UIAlertAction(title: "Exit", style: .destructive, handler: { (action:UIAlertAction!) -> Void in
                exit(0)
             })
        alert.addAction(OkButton)
        alert.addAction(noBtn)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Input value"
        }
        else {
            return "Input value 2"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FuzzyCell
        cell.indexPathOfCell = indexPath.section
        cell.backgroundColor = .white
        return cell
    }
    
    @IBAction func CalculateFuzzy(_ sender: Any) {
        msg = "Var1:\n\(changes[0].Var1!.Ans1):\(changes[0].Var1!.Yvalue1)\n\(changes[0].Var1!.Ans2):\(changes[0].Var1!.Yvalue2)\n\(changes[0].Var1!.Ans3):\(changes[0].Var1!.Yvalue3)\nVar2:\n\(changes[0].Var2!.Ans1):\(changes[0].Var2!.Yvalue1)\n\(changes[0].Var2!.Ans2):\(changes[0].Var2!.Yvalue2)\n\(changes[0].Var2!.Ans3):\(changes[0].Var2!.Yvalue3)"
        ShowAlert()
    }
    
    @IBAction func Aggregation(_ sender: Any) {
        resaggr[0] = min(changes[0].Var1!.Yvalue1, changes[0].Var2!.Yvalue1)//средне
        resaggr[1] = min(changes[0].Var1!.Yvalue1, changes[0].Var2!.Yvalue2)//средне
        resaggr[2] = min(changes[0].Var1!.Yvalue1, changes[0].Var2!.Yvalue3)//мало
        resaggr[3] = min(changes[0].Var1!.Yvalue2, changes[0].Var2!.Yvalue1)//сильно
        resaggr[4] = min(changes[0].Var1!.Yvalue2, changes[0].Var2!.Yvalue2)//мало
        resaggr[5] = min(changes[0].Var1!.Yvalue2, changes[0].Var2!.Yvalue3)//мало
        resaggr[6] = min(changes[0].Var1!.Yvalue3, changes[0].Var2!.Yvalue1)//средне
        resaggr[7] = min(changes[0].Var1!.Yvalue3, changes[0].Var2!.Yvalue2)//мало
        resaggr[8] = min(changes[0].Var1!.Yvalue3, changes[0].Var2!.Yvalue3)//мало
        msg = "\(resaggr[0])\n\(resaggr[1])\n\(resaggr[2])\n\(resaggr[3])\n\(resaggr[4])\n\(resaggr[5])\n\(resaggr[6])\n\(resaggr[7])\n\(resaggr[8])"
        ShowAlert()
    }
    
    @IBAction func Activation(_ sender: Any) {
        aggrrules[0] = max(resaggr[2],resaggr[4],resaggr[5],resaggr[8])
        aggrrules[1] = max(resaggr[0],resaggr[1],resaggr[6])
        aggrrules[2] = resaggr[3]
        try! realm.write{
            //мало
            for i in 0...10 {
                if aggrrules[0] < variative3[i].Yvalue1{
                    resactiv[i].Yvalue1 = aggrrules[0]
                }
                else{
                    resactiv[i].Yvalue1 = variative3[i].Yvalue1
                }
            }
            //средне
                for i in 0...10 {
                    if aggrrules[1] < variative3[i].Yvalue2{
                        resactiv[i].Yvalue2 = aggrrules[1]
                    }
                    else{
                        resactiv[i].Yvalue2 = variative3[i].Yvalue2
                    }
                }
            //сильно
            for i in 0...10 {
                if aggrrules[2] < variative3[i].Yvalue3{
                    resactiv[i].Yvalue3 = aggrrules[2]
                }
                else{
                    resactiv[i].Yvalue3 = variative3[i].Yvalue3
                }
            }
        }
        msg = "\(resactiv[0])\n\(resactiv[1])\n\(resactiv[2])\n\(resactiv[3])\n\(resactiv[4])\n\(resactiv[5])\n\(resactiv[6])\n\(resactiv[7])\n\(resactiv[8])"
        ShowAlert()
    }
    
    @IBAction func Accumulation(_ sender: Any) {
        for i in 0...10 {
            resaccum[i] = max(resactiv[i].Yvalue1,resactiv[i].Yvalue2,resactiv[i].Yvalue3)
        }
        msg = "\(resaccum[0])\n\(resaccum[1])\n\(resaccum[2])\n\(resaccum[3])\n\(resaccum[4])\n\(resaccum[5])\n\(resaccum[6])\n\(resaccum[7])\n\(resaccum[8])\n\(resaccum[9])\n\(resaccum[10])"
        ShowAlert()
    }
    
    @IBAction func Deffuzification(_ sender: Any) {
        var sum = 0.0
        var resDeffuzi = 0.0
        for i in 0...10 {
            resDeffuzi+=Double(variative3[i].Xvalue) * resaccum[i]
            sum+=resaccum[i]
        }
        resDeffuzi=resDeffuzi/sum
        msg = "\(resDeffuzi)"
        ShowAlert()
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
