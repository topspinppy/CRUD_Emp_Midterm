//
//  EditViewController.swift
//  midterm_selected
//
//  Created by Admin on 4/3/2562 BE.
//  Copyright © 2562 KMUTNB. All rights reserved.
//

import UIKit
import SQLite3

class EditViewController: UIViewController {

    @IBOutlet weak var idEmp: UITextField!
    @IBOutlet weak var nameEmp: UITextField!
    @IBOutlet weak var ageEmp: UITextField!
    @IBOutlet weak var birthEmp: UIDatePicker!
    
    let fileName = "db.sqlite"
    let fileManager = FileManager.default
    var dbPath = String()
    var sql = String()
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    var pointer: OpaquePointer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbURL = try! fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
            .appendingPathComponent(fileName)
        let openDb = sqlite3_open(dbURL.path, &db)
        if openDb != SQLITE_OK{
            print("opening database error!")
            return
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateData(_ sender: Any) {
        let idEmployee = idEmp.text
        let nameEmployee = nameEmp.text! as NSString
        let ageEmployee = ageEmp.text! as NSString
        
        
        let currentDate = birthEmp.date
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "dd/MM/YYYY"
        let thaiLocale = NSLocale(localeIdentifier: "TH_th")
        myFormatter.locale = thaiLocale as Locale
        let currentDateText = myFormatter.string(from: currentDate)

        self.sql = "UPDATE people "+"SET "
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
