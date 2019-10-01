//
//  FavoriteTableViewCell.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 10/1/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var faveImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
