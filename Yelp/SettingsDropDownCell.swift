//
//  SettingsDropDownCell.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

class SettingsDropDownCell: UITableViewCell {
    
    static let id = "settingsDropDown"
    
    enum State: String {
        case Collapsed = "downTriangle"
        case Unchecked = "radioboxOff"
        case Checked = "radioboxOn"
        
        func getIcon() -> UIImage {
            return UIImage(named: self.rawValue)!
        }
        
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populate(label labelText:String, state: State) {
        label.text = labelText
        icon.image = state.getIcon()
    }
}
