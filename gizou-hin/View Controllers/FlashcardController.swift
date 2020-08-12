//
//  FlashcardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/11/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class FlashcardController: ViewController {
    
    var flashcards = [Flashcard]()
    var card = Flashcard()
    
    @IBOutlet weak var flashcard: UILabel!
    @IBOutlet weak var wordDesc: UILabel!
    
    @IBOutlet weak var canvas: CanvasView!
    
    
    @IBOutlet weak var incorrectCount: UILabel!
    var incorrect = 0
    
    @IBOutlet weak var correctCount: UILabel!
    var correct = 0
    
    @IBOutlet weak var flipButton: UIButton!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlashcards()
        incorrect = 0
        correct = 0
        correctCount.text = "Correct: \(correct)"
        incorrectCount.text = "Incorrect: \(incorrect)"
        nextCard()
    }
    
    func setupFlashcards(){
        
    }
    
    
    @IBAction func clear(_ sender: Any) {
        canvas.clearCanvas()
    }
    
    @IBAction func exitButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func flipCard(_ sender: Any) {
        flipButton.isHidden = true
        yesButton.isHidden = false
        noButton.isHidden = false
        flashcard.text = card.backText
        wordDesc.text = card.description
        //        flashcard
    }
    
    @IBAction func notRecognized(_ sender: Any) {
        incorrect += 1
        incorrectCount.text = "Incorrect: \(incorrect)"
        nextCard()
    }
    
    @IBAction func recognized(_ sender: Any) {
        correct += 1
        correctCount.text = "Correct: \(correct)"
        nextCard()
    }
    
    func nextCard(){
        if flashcards.count > 0 {
            card = flashcards.remove(at: 0)
            flashcard.text = card.frontText
            wordDesc.text = ""
            flipButton.isHidden = false
            yesButton.isHidden = true
            noButton.isHidden = true
        } else{
            //fin
        }
    }
    @IBAction func goBack(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Quit", message: "Are you sure you want to quit?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.exitButton()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}
