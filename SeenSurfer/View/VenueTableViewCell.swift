//
//  VenueTableViewCell.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/4/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var vibeScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withVenue venue: SeenSurferVenue) {
        bringSubview(toFront: titleLabel)
        bringSubview(toFront: vibeScoreLabel)
        titleLabel.text = venue.name ?? ""
        if let rating = venue.vibeRating {
            vibeScoreLabel.text = "\(Int(rating))"
        }
        guard let imageUrlString = venue.imageUrl, let imageUrl = URL(string: imageUrlString) else { return }
        SeenSurferUtils.shared.set(imageView: backgroundImage, withImageAtUrl: imageUrl)
    }

}
