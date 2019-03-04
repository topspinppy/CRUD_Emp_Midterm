//
//  AddDataViewController.swift
//  midterm_selected
//
//  Created by Admin on 4/3/2562 BE.
//  Copyright © 2562 KMUTNB. All rights reserved.
//

import UIKit
import SQLite3
class AddDataViewController: UIViewController {
    
    @IBOutlet weak var nameEmp: UITextField!
    @IBOutlet weak var ageEmp: UITextField!
    @IBOutlet weak var birthDate: UIDatePicker!
    
    let fileName = "db.sqlite"
    let fileManager = FileManager.default
    var dbPath = String()
    var sql = String()
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    var pointer: OpaquePointer?
    
    
    @IBOutlet weak var Datetest: UILabel!
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
        
    }
    
    @IBAction func SaveData(_ sender: Any) {
        let names = nameEmp.text! as NSString
        let ages = ageEmp.text! as NSString
        
        let currentDate = birthDate.date
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "dd/MM/YYYY"
        let thaiLocale = NSLocale(localeIdentifier: "TH_th")
        myFormatter.locale = thaiLocale as Locale
        let currentDateText = myFormatter.string(from: currentDate)
        Datetest.text = currentDateText
        
        self.sql = "INSERT INTO people VALUES (null,?,?,?)";
        sqlite3_prepare(self.db, self.sql, -1, &self.stmt, nil)
        
        sqlite3_bind_text(self.stmt, 1, names.utf8String, -1, nil)
        sqlite3_bind_text(self.stmt, 2, ages.utf8String , -1, nil)
        sqlite3_bind_text(self.stmt, 3, currentDateText, -1, nil)
        sqlite3_step(self.stmt)
    }
    
    
}
