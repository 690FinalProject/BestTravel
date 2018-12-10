//
//  SpotCell.swift
//  BestTravel
//
//  Created by Jangey Lu on 11/29/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit

class SpotCell: UITableViewCell {

    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotNameLabel: UILabel!
    @IBOutlet weak var spotDescriptionLabel: UILabel!
    
    
    var spot: Spot! {
        didSet{
            let spotName = spot.spotName
            spotNameLabel.text = spotName
            
            let spotDescription = spot.description
            spotDescriptionLabel.text = spotDescription
            
            let iconURL = URL(string: spot.IconURL)!
            spotImage.af_setImage(withURL: iconURL)
            
            //print(spot.id)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
