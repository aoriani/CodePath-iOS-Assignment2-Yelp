//
//  SettingsSwitchCell.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

@objc protocol SettingsSwitchCellDelegate {
    optional func settingsSwitchCell(settingsSwitchCell: SettingsSwitchCell, didChangeValue: Bool)
}

class SettingsSwitchCell: UITableViewCell {
    
    static let id = "settingsSwitch"

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    weak var delegate:SettingsSwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchView.onTintColor = UIColor.redColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(label labelText:String, isOn:Bool, switchDelegate: SettingsSwitchCellDelegate?) {
        label.text = labelText
        switchView.setOn(isOn, animated: false)
        delegate = switchDelegate
    }

    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        delegate?.settingsSwitchCell?(self, didChangeValue: switchView.on)
    }
}
