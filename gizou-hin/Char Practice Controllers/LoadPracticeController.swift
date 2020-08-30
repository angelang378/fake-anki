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
    
    var buttonRows: [Int]! = []
    
    @IBAction func BackButton() {
        dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hirLabel.text = "Select all"
        katLabel.text = "Select all"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        buttonRows = []
        var count = 0
        for button in hirButtons {
            if button.isChecked {
                count += 1
                break
            }
        }
        if count == 0 {
            for button in katButtons {
                if button.isChecked {
                    count += 1
                    break
                }
            }
        }
        
        if count == 0{
            let refreshAlert = UIAlertController(title: "You must select at least one category to continue", message: "", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert.dismiss(animated: true, completion: nil)
            }))
        
            present(refreshAlert, animated: true, completion: nil)
            
        } else {
            for x in hirButtons {
                if x.isChecked{
                    buttonRows.append(x.tag-1)
                }
            }
            for x in katButtons {
                if x.isChecked{
                    buttonRows.append(x.tag-1)
                }
            }
            performSegue(withIdentifier: "goToPractice", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? CharPracticeController{
            vc.charRows = buttonRows
        }
    }
    
    @IBAction func checkbox(_ sender: CheckBox){
        if sender.isChecked {
            if sender.tag - 18 < 0 && sender.tag != 0 {
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
