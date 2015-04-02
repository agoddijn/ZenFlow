//
//  ImageCellTableViewCell.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 14/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import UIKit

class ImageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
