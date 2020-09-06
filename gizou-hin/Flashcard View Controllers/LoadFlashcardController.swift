//
//  LoadFlashcardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/30/20.
//  Copyright © 2020 Angela Ng. All rights reserved.


import UIKit
import CoreData

class LoadFlashcardController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    private var moc: NSManagedObjectContext!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var fetchedRC: NSFetchedResultsController<Deck>!
    
    var selectedDeck : Deck?
    var selectedRow : IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.popToRootViewController(animated: false)

        tableView.delegate = self
        tableView.dataSource = self
        
        moc = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = Deck.fetchRequest() as NSFetchRequest<Deck>
        let sort = NSSortDescriptor(key: #keyPath(Deck.name), ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
            //            loadData()
            
        } catch let error as NSError {
            print("Could not fetch decks. \(error), \(error.userInfo)")
        }
        
        if selectedRow != nil {
            tableView.beginUpdates()
            tableView.reloadRows(at: [selectedRow!]
                , with: .automatic)
            tableView.endUpdates()
        }
    }
    
    @IBAction func addDeck(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Deck", message: "Add a new deck", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let deckToSave = textField.text else{
                    return
            }
 
            let newDeck = Deck(context: self.moc)
            newDeck.name = deckToSave
            newDeck.timeStamp = NSDate() as Date
            self.appDelegate.saveContext()
            self.tableView.reloadData()
        }
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    //delete item from table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let deck = fetchedRC.object(at: indexPath) as Deck
            moc.delete(deck)
            appDelegate.saveContext()
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let decks = fetchedRC.fetchedObjects else {return 0}
        return decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.898039, green: 1, blue: 1, alpha: 1)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let deck = fetchedRC.object(at: indexPath)
        
        cell.textLabel?.text = deck.name
        cell.detailTextLabel?.text = "\(deck.hasCards?.count ?? 0) card(s) in deck"
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Current Decks"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(red: 0.690196, green: 0.956863, blue: 0.647059, alpha: 1)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDeck = fetchedRC.object(at: indexPath)
        selectedRow = indexPath
        performSegue(withIdentifier: "openDeck", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDeck" {
            let nc = segue.destination as! UINavigationController
            
            if let vc = nc.topViewController as? ViewCardsInDeckController{
                vc.navigationItem.title = selectedDeck!.name
                vc.deck = selectedDeck!
            }
        }
    }
}

extension LoadFlashcardController: NSFetchedResultsControllerDelegate {
    
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
