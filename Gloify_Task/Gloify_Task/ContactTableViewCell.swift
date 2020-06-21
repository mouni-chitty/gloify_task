//
//  ContactTableViewCell.swift
//  Gloify_Task
//
//  Created by Mounika K on 21/06/20.
//  Copyright © 2020 Mounika K. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var localContact: LocalContact? {
        didSet {
            nameLabel.text = localContact?.name
            numberLabel.text = localContact?.number
            emailLabel.text = localContact?.email
        }
    }

}
