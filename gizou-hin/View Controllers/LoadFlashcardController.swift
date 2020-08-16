//
//  LoadFlashcardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/30/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit
import CoreData

class LoadFlashcardController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var decks = [Deck]()
    private var moc: NSManagedObjectContext!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var fetchedRC: NSFetchedResultsController<Deck>!

    var selectedDeck : Deck?
    
    @IBAction func BackButton() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
//        tableView.dataSource = self
        
        moc = appDelegate.persistentContainer.viewContext
        
        loadData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let request = Deck.createFetchRequest() as NSFetchRequest<Deck>
//        let sort = NSSortDescriptor(key: #keyPath(Deck.name), ascending: true)
//
//        request.sortDescriptors = [sort]
//
//        do {
//            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
//            try fetchedRC.performFetch()
//            fetchedRC.delegate = self
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
    }
    
    @IBAction func addDeck(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Deck", message: "Add a new deck", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in

            guard let textField = alert.textFields?.first,
                let deckToSave = textField.text else{
                    return
            }
            self.saveDeck(name: deckToSave)
        }

        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    func saveDeck(name: String){
        let newDeck = Deck(context: moc)
        newDeck.name = name
        
        do{
            try moc.save()
            decks.append(newDeck)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        loadData()
    }
    
    func loadData() {
        let deckRequest: NSFetchRequest<Deck> = Deck.createFetchRequest()
        
        do {
            try decks = moc.fetch(deckRequest)
        } catch {
            print("Could not load data")
        }
        
        self.tableView.reloadData()
    }
    
    
    //delete item from table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let deck = decks[indexPath.row]
            moc.delete(deck)
            do {
                try moc.save()
            } catch let error as NSError{
                print("Could not delete. \(error), \(error.userInfo)")
            }
            decks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.898039, green: 1, blue: 1, alpha: 1)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let deck = decks[indexPath.row]
        cell.textLabel?.text = deck.name
//        cell.detailTextLabel!.text = "\(deck.hasCards?.count ?? 0) card(s) in deck"
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

}
