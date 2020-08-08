//
//  QuitSceneController.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/2/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class QuitSceneController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ExitButton() {
        dismiss(animated: true, completion: nil)
    }
    

}
