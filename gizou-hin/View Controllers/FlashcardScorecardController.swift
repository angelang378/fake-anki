//
//  FlashcardScorecardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/29/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class FlashcardScorecardController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var correctAns: UILabel!
    var numCorrect = 0
    @IBOutlet weak var incorrectAns: UILabel!
    var numIncorrect = 0
    
    var missedCards = [Flashcard]()
    var entireDeck = [Flashcard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correctAns.text = "\(numCorrect)"
        incorrectAns.text = "\(numIncorrect)"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "Cards Missed"
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missedCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissedCardCell", for: indexPath)
        cell.textLabel!.text = missedCards[indexPath.row].frontText
        cell.detailTextLabel!.text = missedCards[indexPath.row].backText

        return cell
    }

    @IBAction func repeatDeck(_ sender: Any) {
        if missedCards.count == 0 {
            let refreshAlert = UIAlertController(title: "There are no missed flashcards to review!", message: "Select a different option", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert.dismiss(animated: true, completion: nil)
            }))
            present(refreshAlert, animated: true, completion: nil)
        } else{
            performSegue(withIdentifier:  "practiceMissedSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FlashcardController {
            if segue.identifier == "practiceMissedSegue" {
                vc.flashcards = missedCards
            }
            else {
                vc.flashcards = entireDeck
            }
        }
    }

}
