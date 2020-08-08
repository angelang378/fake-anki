//
//  CustomTableViewCell.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/3/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    

 
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
