//
//  LoadPracticeController.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/30/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class LoadPracticeController: UIViewController{
    
    @IBOutlet var hirButtons: [CheckBox]!
    @IBOutlet var katButtons: [CheckBox]!
    
    @IBOutlet weak var katAll: CheckBox!
    @IBOutlet weak var hirAll: CheckBox!
    
    @IBOutlet weak var hirLabel: UILabel!
    @IBOutlet weak var katLabel: UILabel!
    
    @IBAction func BackButton() {
        dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hirLabel.text = "Select all"
        katLabel.text = "Select all"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkbox(_ sender: CheckBox){
        if sender.isChecked {
            if sender.tag == 1{
                hirAll.isChecked = false
                hirLabel.text = "Select all"
            }
            else{
                katAll.isChecked = false
                katLabel.text = "Select all"
            }
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func checkAllHir(_ sender: CheckBox){
        var count = 0
        if !sender.isChecked {
            for button in self.hirButtons {
                if !button.isChecked{
                    button.isChecked = true
                    count += 1
                }
            }
            hirLabel.text = "Deselect all"
        }
        if count == 0 {
            for button in self.hirButtons {
                button.isChecked = false
            }
            hirLabel.text = "Select all"
        }
    }
    
    @IBAction func checkAllKat(_ sender: CheckBox){
        var count = 0
        if !sender.isChecked {
            for button in self.katButtons {
                if !button.isChecked{
                    button.isChecked = true
                    count += 1
                }
            }
            katLabel.text = "Deselect all"
        }
        if count == 0 {
            for button in self.katButtons {
                button.isChecked = false
            }
            katLabel.text = "Select all"
        }
    }
    
    
}
