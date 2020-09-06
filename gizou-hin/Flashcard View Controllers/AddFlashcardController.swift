//
//  AddFlashcardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/28/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit
import CoreData

class AddFlashcardController: UIViewController {
    
    @IBOutlet weak var vocabWord: UITextField!
    
    @IBOutlet weak var meaning: UITextField!
    @IBOutlet weak var wordDesc: UITextField!
    
    @IBOutlet weak var topWarning: UILabel!
    @IBOutlet weak var bottomWarning: UILabel!
    
    var deck : Deck!
    var edit:Bool = false
    var frontText: String?
    var backText: String?
    var desc: String?
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var moc : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topWarning.isHidden = true
        bottomWarning.isHidden = true
        
        moc = appDelegate.persistentContainer.viewContext
        
        //if editing a card
        if edit {
            vocabWord.text = frontText
            meaning.text = backText
            wordDesc.text = desc ?? ""
        } 
    }
    
    func resetFields(){
        
        vocabWord.text = ""
        meaning.text = ""
        wordDesc.text = ""
    }
    
    func hasEmptyField() -> Bool {
        topWarning.isHidden = (vocabWord.text!.trimmingCharacters(in: .whitespaces).isEmpty) ? false : true
        bottomWarning.isHidden = (meaning.text!.trimmingCharacters(in: .whitespaces).isEmpty) ? false : true
        return !(topWarning.isHidden && bottomWarning.isHidden)
    }
    
    
    @IBAction func saveWord(_ sender: Any) {
        if !hasEmptyField() {
            if (edit){
                let request = Flashcard.fetchRequest() as NSFetchRequest<Flashcard>
                request.predicate = NSPredicate(format: "inDeck = %@ AND frontText = %@ AND backText = %@", argumentArray:[deck!, frontText!, backText!])
                do {
                    let results = try moc.fetch(request)
                    if results.count != 0 {
                        results[0].setValue(vocabWord.text!.trimmingCharacters(in: .whitespaces), forKey: "frontText")
                        results[0].setValue(meaning.text!.trimmingCharacters(in: .whitespaces), forKey: "backText")
                        results[0].setValue(wordDesc.text!.trimmingCharacters(in: .whitespaces), forKey: "desc")
                    }
                } catch {
                    print("Fetch failed: \(error)")
                }
                
            } else{
                let card = Flashcard(context: moc)
                card.frontText = vocabWord.text!.trimmingCharacters(in: .whitespaces)
                card.backText = meaning.text!.trimmingCharacters(in: .whitespaces)
                card.desc = wordDesc?.text!.trimmingCharacters(in: .whitespaces)
                card.inDeck = deck!
                card.timeStamp = NSDate() as Date
            }
            appDelegate.saveContext()
            dismiss(animated: true, completion: nil)        }
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
