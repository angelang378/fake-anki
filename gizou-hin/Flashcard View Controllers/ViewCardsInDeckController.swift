//
//  ViewCardsInDeckController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/20/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit
import CoreData

class ViewCardsInDeckController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var deck:Deck!
    
    @IBOutlet weak var reverseButton: CheckBox!
    
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    private var fetchedRC:NSFetchedResultsController<Flashcard>!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var moc:NSManagedObjectContext!
    
    var selectedCard:Flashcard?
    var selectedRow : IndexPath?
    var edit: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        moc = appDelegate.persistentContainer.viewContext
        headerView.layer.borderColor = UIColor.black.cgColor
        headerView.layer.borderWidth = 1
        loadTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let request = Flashcard.fetchRequest() as NSFetchRequest<Flashcard>
        let sort = NSSortDescriptor(key: #keyPath(Flashcard.timeStamp), ascending: true)
        
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "inDeck = %@", deck!)
        
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
            loadTable()
            
            if edit {
                tableView.beginUpdates()
                tableView.reloadRows(at: [selectedRow!]
                    , with: .automatic)
                tableView.endUpdates()
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cards = fetchedRC.fetchedObjects else {return 0}
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filledCell") as! FilledCell
        let card = fetchedRC.object(at: indexPath)
        cell.meaning.text = card.backText
        cell.word.text = card.frontText
        cell.desc.text = (card.desc ?? "").isEmpty ? "" : card.desc
        return cell
        
    }
    
    @IBAction func BackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func loadTable(){
        if let cards = fetchedRC?.fetchedObjects {
            emptyMessage.isHidden = (cards.count == 0) ? false : true
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let card = fetchedRC.object(at: indexPath) as Flashcard
            moc.delete(card)
            appDelegate.saveContext()
            
            loadTable()
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = fetchedRC.object(at: indexPath)
        selectedRow = indexPath
        performSegue(withIdentifier: "editFlashcardSegue", sender: self)
    }
    
    
    @IBAction func startReview(_ sender: Any) {
        if fetchedRC.fetchedObjects?.count ?? 0 > 0{
            performSegue(withIdentifier: "startFlashcards", sender: self)
        } else{
            let refreshAlert = UIAlertController(title: "There are no flashcards to review!", message: "Add flashcards by pressing the button in the top right corner.", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    refreshAlert.dismiss(animated: true, completion: nil)
                }))
            
                present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startFlashcards"{
            if let vc = segue.destination as? FlashcardController {
                if reverseButton.isChecked {
                    vc.reverseCards = true
                }
                vc.flashcards = fetchedRC.fetchedObjects!
            }
        } else{
            let nc = segue.destination as! UINavigationController
            if let vc = nc.topViewController as? AddFlashcardController{
                
                if segue.identifier == "editFlashcardSegue"{
                    if (selectedCard != nil){
                        edit = true
                        vc.frontText = selectedCard!.frontText
                        vc.backText = selectedCard!.backText
                        vc.edit = true
                        vc.desc = (selectedCard!.desc ?? "").isEmpty ? "" : selectedCard!.desc
                        
                    }
                } else{
                    edit = false
                }
                vc.deck = deck!
            }
        }

    }
}

class FilledCell : UITableViewCell { 
    
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var meaning: UILabel!
}

extension ViewCardsInDeckController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        let index = indexPath ?? (newIndexPath ?? nil)
        guard let cellIndex = index else { return }
        switch type {
        case .insert:
            tableView.insertRows(at: [cellIndex], with: .fade)
        case .delete:
            tableView.deleteRows(at: [cellIndex], with: .fade)
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
}

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
