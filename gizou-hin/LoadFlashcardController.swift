//
//  LoadFlashcardController.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/30/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class LoadFlashcardController: UIViewController {

    @IBOutlet weak var checkBox1: CheckBox!
    
    @IBAction func BackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
