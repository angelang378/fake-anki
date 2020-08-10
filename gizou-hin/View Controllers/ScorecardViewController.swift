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
        return "Characters answered incorrectly"
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
        //        cell.backgroundColor = UIColor(hexString: "EEE6DA")
        return cell
    }
    
}

//hex to uicolor converter code from SO
//extension UIColor {
//    convenience init(hexString: String) {
//        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int = UInt64()
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//    }
//}
