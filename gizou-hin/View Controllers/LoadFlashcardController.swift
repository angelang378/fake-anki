//
//  LoadFlashcardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/30/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit
import CoreData

class LoadFlashcardController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var decks: [NSManagedObject] = []
    
    @IBAction func BackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Decks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Deck")
        
        do{
            decks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
            
            self.save(name: deckToSave)
            self.tableView.reloadData()
        }
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func save(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Deck", in: managedContext)!
        
        let deck = NSManagedObject(entity: entity, insertInto: managedContext)
        
        deck.setValue(name, forKeyPath: "name")
        
        do{
            try managedContext.save()
            decks.append(deck)
        } catch let error as NSError{
            print("Could not savve. \(error), \(error.userInfo)")
        }
    }


    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let deck = decks[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text = deck.value(forKeyPath: "name") as? String
            return cell
    }
}
