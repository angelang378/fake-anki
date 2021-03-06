//
//  ScorecardViewController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/7/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class ScorecardViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var correct: UILabel!
    var numCorrect = 0
    
    @IBOutlet weak var incorrect: UILabel!
    var numIncorrect = 0
    
    @IBOutlet weak var tableOfWrongAnswers: UITableView!
    
    var missedChars = [Char]()
    var allChars = [Char]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correct.text = "\(numCorrect)"
        incorrect.text = "\(numIncorrect)"
        tableOfWrongAnswers.delegate = self
        tableOfWrongAnswers.dataSource = self
    }
    
    @IBAction func repeatChars(_ sender: Any) {
        if missedChars.count == 0 {
            let refreshAlert = UIAlertController(title: "There are no incorrect characters to review!", message: "Select a different option", preferredStyle: UIAlertController.Style.alert)
            
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
            if segue.identifier == "practiceMissedChars" {
                vc.chars = missedChars.shuffled()
            }
            else {
                vc.chars = allChars.shuffled()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Missed characters"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(red: 0.898039, green: 0.772549, blue: 0.627451, alpha: 1)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missedChars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncorrectCharCell", for: indexPath)
        cell.textLabel!.text = missedChars[indexPath.row].value[0]
        cell.imageView?.image = UIImage(named: missedChars[indexPath.row].imageName)
        cell.backgroundColor = UIColor(red: 0.933333, green: 0.901961, blue: 0.854902, alpha: 1)
        return cell
    }
    
}
