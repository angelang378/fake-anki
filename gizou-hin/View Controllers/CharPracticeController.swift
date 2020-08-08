//
//  CharPracticeController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/1/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class CharPracticeController: UIViewController, UITextFieldDelegate {
    
    var charRows: [Int]!
    
    var charDeck = [Char]()
    var chars = [Char]()
    var currentChar : [String]! = []
    var char = Char()
    var currentCharImage : UIImage?
    var firstView : Bool = true
    var total = 0
    var curr = 0
    
    var wrongAnswers: [Char]! = []
    
    var correct = 0
    @IBOutlet weak var numCorrect: UILabel!
    var incorrect = 0
    @IBOutlet weak var numIncorrect: UILabel!
    
    @IBOutlet weak var revealAnswer: UILabel!
    @IBOutlet weak var charOnScreen: UIImageView!
    
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var progressBar: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChars()
        charDeck = chars
        total = chars.count
        nextChar()
        self.userInput.delegate = self
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        checkAnswer()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userInput.resignFirstResponder()  //if desired
        checkAnswer()
        return true
    }
    
    func setUpChars(){
        if chars.count == 0{
            self.chars = CharModel().getChars(sender: charRows)
        }
    }
    
    func nextChar(){
        revealAnswer.text = ""
        if chars.count > 0{
            self.char = self.chars.remove(at: 0)
            self.currentChar = char.value
            self.firstView = true
            charOnScreen.image = UIImage(named: char.imageName)! as UIImage
            curr += 1
            progressBar.text = "\(curr)/\(total)"
            progress.progress = Float(curr)/Float(total)
        } else{
            performSegue(withIdentifier: "goToWinScreen", sender: self)
        }
        
    }
    
    func wrongAnswer (){
        incorrect += 1
        numIncorrect.text = "Incorrect: \(incorrect)"
        charOnScreen.shake()
        self.firstView = false
        wrongAnswers.append(char)
    }
    
    func rightAnswer(){
        userInput.text = ""
        nextChar()
    }
    
    func checkAnswer() {
        if firstView {
            if currentChar.contains(userInput.text!.lowercased()){
                correct += 1
                numCorrect.text = "Correct: \(correct)"
                rightAnswer()
            }
            else {
                wrongAnswer()
            }
        } else{
            if currentChar.contains(userInput.text!.lowercased()){
                rightAnswer()
            } else{
                charOnScreen.shake()
            }
        }
    }
    
    @IBAction func ExitButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Quit", message: "Are you sure you want to quit?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.ExitButton()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func showAnswer(_ sender: Any) {
        revealAnswer.text = currentChar[0]
        if self.firstView {
            wrongAnswer()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? ScorecardViewController{
            vc.numCorrect = correct
            vc.numIncorrect = incorrect
            vc.missedChars = wrongAnswers
            vc.allChars = charDeck
        }
    }
    
}

//stackoverflow
extension UIView {
    func shake() {
        let shakes = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakes.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakes.duration = 0.6
        shakes.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(shakes, forKey: "shake")
    }
}

