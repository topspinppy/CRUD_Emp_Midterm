//
//  ViewController.swift
//  midterm_selected
//
//  Created by Admin on 4/3/2562 BE.
//  Copyright © 2562 KMUTNB. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    @IBOutlet weak var TextView: UITextView!
    
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
        
        sql = "CREATE TABLE IF NOT EXISTS people (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, AGE TEXT, BIRTH TEXT)"
        
        let createTb = sqlite3_exec(db, sql, nil, nil, nil)
        if createTb != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print(err)
        }
        sql = "INSERT INTO people (id, name, age, birth) VALUES ('1', 'สมชาย พายเรือ' , '22', '22 March 1997')"
        sqlite3_exec(db,sql,nil,nil,nil)
        select()
    }

    func select() {
        sql = "SELECT * FROM people"
        sqlite3_prepare(db, sql, -1, &pointer, nil)
        TextView.text = ""
        
        var id: Int32
        var name: String
        var ages: String
        var birth: String
        
        while(sqlite3_step(pointer) == SQLITE_ROW)
        {
            id = sqlite3_column_int(pointer, 0)
            TextView.text?.append("id: \(id)\n")
            
            name = String(cString: sqlite3_column_text(pointer, 1))
            TextView.text?.append("name: \(name) \n")
            
            ages = String(cString: sqlite3_column_text(pointer, 2))
            TextView.text?.append("age: \(ages)\n")
            
            birth = String(cString: sqlite3_column_text(pointer, 3))
            TextView.text?.append("birth: \(birth)\n")
            
        }
    }
    @IBAction func refreshs(_ sender: Any) {
        self.viewDidLoad()
    }
    
    @IBAction func Delete(_ sender: Any) {
        let alert = UIAlertController(
            title: "ลบข้อมูลพนักงาน",
            message: "กรุณาใส่ ไอดีของแถวที่ต้องการลบ",
            preferredStyle: .alert
        )
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "ID ของแถวที่ต้องการลบ"
            tf.font = UIFont.systemFont(ofSize: 18)
            tf.keyboardType = .numberPad
        })
        
        let btCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let btOk = UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            guard let id = Int32(alert.textFields!.first!.text!) else {
                return
            }
            self.sql = "DELETE FROM people WHERE id = \(id)"
            sqlite3_exec(self.db, self.sql, nil, nil, nil)
            self.select()
    
        })
        
        alert.addAction(btCancel)
        alert.addAction(btOk)
        present(alert, animated: true, completion: nil)
    }
    
}

