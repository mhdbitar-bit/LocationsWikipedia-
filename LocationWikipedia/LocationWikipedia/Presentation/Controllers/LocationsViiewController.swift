//
//  LocationsViiewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import UIKit

final class LocationsListViewController: UITableViewController, Alertable {
    
    private enum LocationError: String {
        case InvalidLocation = "Invalid location, Can't open this location."
    }
    
    let cellID = "LocationTableViewCell"
    var locations = [Location]()
    var service: LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            refresh()
        }
    }
    
    @objc private func refresh() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl?.beginRefreshing()
        }
        service?.getLocations(completion: handleAPIResult)
    }
    
    private func handleAPIResult(_ result: Result<[Location], Error>) {
        switch result {
        case let .success(locations):
            self.locations = locations
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
            
        case .failure(_):
            refresh()
            return
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = locations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! LocationTableViewCell
        cell.configure(item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openLocationInWiki(locations[indexPath.row])
    }
    
    private func openLocationInWiki(_ location: Location) {
        let locationBaseUrlStr = LocationURL.scheme
        + "://"
        + LocationURL.host
        
        var queryItems = [URLQueryItem]()

        let latitude = location.coordinators.latitude
        let longitude = location.coordinators.longitude
        queryItems = [
            URLQueryItem(name: LocationURL.latitude, value: "\(latitude)"),
            URLQueryItem(name: LocationURL.longitude, value: "\(longitude)")
        ]
        
        guard var urlComps = URLComponents(string: locationBaseUrlStr) else {
            showAlert(message: LocationError.InvalidLocation.rawValue)
            return
        }
        
        urlComps.queryItems = queryItems
        
        guard let locationUrl = urlComps.url else {
            showAlert(message: LocationError.InvalidLocation.rawValue)
            return
        }
        
        if UIApplication.shared.canOpenURL(locationUrl) {
            UIApplication.shared.open(locationUrl, options: [:], completionHandler: nil)
        } else {
            showAlert(message: LocationError.InvalidLocation.rawValue)
        }
    }
}
