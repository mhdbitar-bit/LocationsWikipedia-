//
//  LocationTableViewCell.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/4/22.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var longLabel: UILabel!
    
    func configure(_ location: Location) {
        nameLabel.text = location.name
        latLabel.text = "\(location.coordinators.latitude)"
        longLabel.text = "\(location.coordinators.longitude)"
    }
}
