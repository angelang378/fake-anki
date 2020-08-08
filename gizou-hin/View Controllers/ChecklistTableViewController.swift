//
//  ChecklistTableViewController.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/31/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class ChecklistTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var allStudentsArr:[[String:String]] = [["name":"あ、お、え、い、う"],["name":"か、き、く、け、こ"],["name":"さ、し、す、せ、そ"],["name":"た、ち、つ、て、と"],["name":"は、ひ、ふ、へ、ほ"],["name":"ら、り、る、れ、ろ"],["name":"ま、み、む、め、も"],["name":"な、に、ぬ、ね、の"],["name":"や、ゆ、よ"],["name":"を、わ"],["name":"ん"]]
    var selectedRows:[IndexPath] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //        allStudentsArr = [["name":"あ、お、え、い、う"],["name":"か、き、く、け、こ"],["name":"さ、し、す、せ、そ"],["name":"た、ち、つ、て、と"],["name":"は、ひ、ふ、へ、ほ"],["name":"ら、り、る、れ、ろ"],["name":"ま、み、む、め、も"],["name":"な、に、ぬ、ね、の"],["name":"や、ゆ、よ"],["name":"を、わ"],["name":"ん"]]
//        allStudentsArr = [["name":"name1"],["name":"name2"],["name":"name3"],["name":"name4"],["name":"name5"],["name":"name6"],["name":"name7"],["name":"name8"]]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStudentsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        cell.nameLbl.text = allStudentsArr[indexPath.row]["name"]
        if selectedRows.contains(indexPath)
        {
            cell.checkBox.setImage(UIImage(named:"checked"), for: .normal)
        }
        else
        {
            cell.checkBox.setImage(UIImage(named:"unchecked"), for: .normal)
        }
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(CheckBox.clicked(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func checkBoxSelection(_ sender:CheckBox)
    {
        let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
        if self.selectedRows.contains(selectedIndexPath)
        {
            self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
        }
        else
        {
            self.selectedRows.append(selectedIndexPath)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func checkbox(_ sender: CheckBox){
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func selectAllBtnAction(_ sender: UIBarButtonItem) {
        self.selectedRows = getAllIndexPaths()
        self.tableView.reloadData()
    }
    
    func getAllIndexPaths() -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for j in 0..<tableView.numberOfRows(inSection: 0) {
            indexPaths.append(IndexPath(row: j, section: 0))
        }
        return indexPaths
    }
}

