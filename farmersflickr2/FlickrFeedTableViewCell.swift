//
//  FlickrFeedTableViewCell.swift
//  farmersflickr2
//
//  Created by Lawrence Chang on 3/29/16.
//  Copyright © 2016 Lawrence Chang. All rights reserved.
//

import UIKit

class FlickrFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel :UILabel?
    @IBOutlet weak var mediaImageView :UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
