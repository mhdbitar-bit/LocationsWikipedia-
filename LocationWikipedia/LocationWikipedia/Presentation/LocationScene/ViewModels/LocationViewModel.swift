//
//  LocationViewModel.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/5/22.
//

import Foundation
import Combine

final class LocationViewModel {
    private let service: LocationService
    
    @Published var locations: [Location] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
   
    init(service: LocationService) {
        self.service = service
    }
    
    public func loadLocations() {
        isLoading = true
        service.getLocations(completion: handleAPIResult)
    }
    
    private func handleAPIResult(_ result: Result<[Location], Error>) {
        isLoading = false
        switch result {
        case let .success(locations):
            self.locations = locations
            
        case let .failure(error):
            self.error = error.localizedDescription
        }
    }
}
