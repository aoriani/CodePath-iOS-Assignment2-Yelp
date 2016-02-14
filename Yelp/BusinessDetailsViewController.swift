//
//  BusinessDetailsViewController.swift
//  Yelp
//
//  Created by Andre Oriani on 2/14/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

class BusinessDetailsViewController: UIViewController {

    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingImaview: UIImageView!
    @IBOutlet weak var snippetContentView: UIView!
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!

    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.prompt = "Yelp?"
        self.navigationItem.title = business.name
        
        // Set the snippet view to have round conners
        snippetContentView.layer.borderColor = UIColor.redColor().CGColor
        snippetContentView.layer.borderWidth = 1.0
        snippetContentView.layer.cornerRadius = 10.0
        snippetContentView.clipsToBounds = true
        
        thumbnailView.fadedSetImageWithUrl(NSURL(string: business.imageUrl)!)
        ratingImaview.fadedSetImageWithUrl(NSURL(string: business.ratingImageURL)!)
        titleLabel.text = business.name
        snippetLabel.text = business.snippetText
        
        //Address textview
        var address = business.location.address[0]
        address += "\n\(business.location.city), \(business.location.state) \(business.location.zipCode)"
        if business.phoneNumber != nil {
            address += "\n\(business.phoneNumber!)"
        }
        addressTextView.text = address
    }

    @IBAction func seeMoreDetailsButtonTapped(sender: AnyObject) {
        let mobileUrl = NSURL(string: business.mobile_url)!
        //Open the Yelp Page in browser
        UIApplication.sharedApplication().openURL(mobileUrl)
    }
    
}
