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
    
    func configure(_ vm: LocationViewModel) {
        nameLabel.text = vm.name
        latLabel.text = "\(vm.coordinators.latitude)"
        longLabel.text = "\(vm.coordinators.longitude)"
    }
}
