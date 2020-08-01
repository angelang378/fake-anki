//
//  CheckBox.swift
//  gizou-hin
//
//  Created by Angela Ng on 7/31/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checked = UIImage(named: "checked")! as UIImage
    let unChecked = UIImage(named: "unchecked")! as UIImage
    
    var isChecked:Bool = false{
        didSet{
            if isChecked {
                self.setImage(checked, for: .normal)
            } else{
                self.setImage(unChecked, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.clicked(_:)), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func clicked(_ sender: UIButton){
        if sender == self{
            isChecked = !isChecked
        }
    }

}
