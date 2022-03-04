//
//  LocationViewModel.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/4/22.
//

import Foundation

struct LocationViewModel {
    let name: String
    let coordinators: (latitude: Double, longitude: Double)
    let select: () -> Void
}

extension LocationViewModel {
    init(location: LocationDTO, selection: @escaping () -> Void) {
        name = location.name
        coordinators = (latitude: location.latitude, longitude: location.longitude)
        select = selection
    }
}
