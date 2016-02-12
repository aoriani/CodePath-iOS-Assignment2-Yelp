//
//  BusinessTableCell.swift
//  Yelp
//
//  Created by Andre Oriani on 2/11/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit


class BusinessTableCell: UITableViewCell {
    
    static let distanceFormatter = NSNumberFormatter()

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = 5
        businessImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(business: Business) {
        businessImageView.fadedSetImageWithUrl(NSURL(string: business.imageUrl)!)
        ratingImageView.fadedSetImageWithUrl(NSURL(string: business.ratingImageURL)!)
        categoryLabel.text = business.categories
        reviewCountLabel.text = "\(business.reviewCount) reviews"
        businessNameLabel.text = business.name
        
        if business.distanceMiles != nil {
            distanceLabel.text = formatDistance(business.distanceMiles!)
        } else {
            distanceLabel.text = "Unk."
        }
        
        addressLabel.text = formatAddress(business.location)
        
    }
    
    func formatDistance(distance: NSDecimalNumber) -> String {
        BusinessTableCell.distanceFormatter.minimumFractionDigits = 1
        BusinessTableCell.distanceFormatter.maximumFractionDigits = 1
        BusinessTableCell.distanceFormatter.minimumIntegerDigits = 1
        let distString = BusinessTableCell.distanceFormatter.stringFromNumber(distance)!
        return "\(distString) mi"
    }
    
    func formatAddress(location: Location) -> String {
        let streetAddress = location.address[0]
        return "\(streetAddress), \(location.city)"
    }
}