//
//  PetTableCell.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import UIKit

class PetTableCell: UITableViewCell {
    
    @IBOutlet var petImageView: LazyImageView!
    @IBOutlet var petNameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

