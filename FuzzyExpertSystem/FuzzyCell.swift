//
//  FuzzyCell.swift
//  FuzzyExpertSystem
//
//  Created by Georgy on 18.12.2022.
//

import UIKit
import RealmSwift
class FuzzyCell: UITableViewCell,UITextFieldDelegate {
    let realm = try! Realm(configuration: .init(schemaVersion: 4))
    let changes = try! Realm().objects(VaritivesChanges.self)
    let variative1 = try! Realm().objects(Variative1.self)
    let variative2 = try! Realm().objects(Variative2.self)
    let variative3 = try! Realm().objects(Variative3.self)
    
    var indexPathOfCell = 0
    @IBOutlet weak var TextCell: UITextField!
    func textFieldDidEndEditing(_ textField: UITextField) {
        try! realm.write{
        switch indexPathOfCell {
        case 0:
            changes[0].Var1 = variative1[Int(String(TextCell.text!))!]
        case 1:
            changes[0].Var2 = variative2[Int(Double(String(TextCell.text!))!*10)]
            return
        default:
            return
        }
      
            self.realm.add(changes)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        TextCell.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
        // Configure the view for the selected state
    }

}
