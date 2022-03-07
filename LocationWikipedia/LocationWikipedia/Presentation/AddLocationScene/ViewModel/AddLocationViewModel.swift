//
//  AddLocationViewModel.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/7/22.
//

import Foundation
import Combine

final class AddLocationViewModel {
    
    let title: String = "Add Location"
    @Published var name: String = ""
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    
    private(set) lazy var isInputValid = Publishers.CombineLatest($latitude, $longitude)
        .map { !$0.isEmpty && !$1.isEmpty }
        .eraseToAnyPublisher()
}
