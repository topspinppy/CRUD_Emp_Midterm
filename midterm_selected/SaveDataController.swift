//
//  SaveDataController.swift
//  midterm_selected
//
//  Created by Admin on 4/3/2562 BE.
//  Copyright © 2562 KMUTNB. All rights reserved.
//

import UIKit

class SaveDataController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ageText: UILabel!
    @IBOutlet weak var textAge: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageText.text = "ปปปหห"
    }
    
}
