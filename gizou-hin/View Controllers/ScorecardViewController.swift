//
//  ScorecardViewController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/7/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class ScorecardViewController: ViewController {
    
    
    @IBOutlet weak var correct: UILabel!
    var numCorrect = 0
    
    @IBOutlet weak var incorrect: UILabel!
    var numIncorrect = 0
    
    var missedChars = [Char]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correct.text = "Correct: \(numCorrect)"
        incorrect.text = "Incorrect: \(numIncorrect)"
    }
    
    @IBAction func repeatChars(_ sender: Any) {
        if missedChars.count == 0 {
            let refreshAlert = UIAlertController(title: "There are no incorrect characters to review!", message: "Click main menu to exit this screen", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert.dismiss(animated: true, completion: nil)
            }))
            present(refreshAlert, animated: true, completion: nil)
        } else{
            performSegue(withIdentifier:  "practiceMissedChars", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CharPracticeController {
            vc.chars = missedChars
        }
    }
    
}
