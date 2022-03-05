//
//  LocationsViiewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import UIKit

final class LocationsListViewController: UITableViewController {
    
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
//        let locationBaseUrlStr = LocationURL.scheme
//          + "://"
//          + LocationURL.host
//        
//        var queryItems = [URLQueryItem]()
//        // Check for available coordinates
//        if let latitude = location.latitude, let longitude = location.longitude {
//          queryItems = [URLQueryItem(name: LocationURL.latitude, value: latitude), URLQueryItem(name: LocationURL.longitude, value: longitude)]
//        } else {
//          // Pass just the place
//          queryItems = [URLQueryItem(name: LocationURL.place, value: location.place)]
//        }
//        
//        guard var urlComps = URLComponents(string: locationBaseUrlStr) else {
//          debugPrint("Invalid location base url")
//          return
//        }
//        
//        urlComps.queryItems = queryItems
//        
//        guard let locationUrl = urlComps.url else {
//          debugPrint("Invalid location final url")
//          return
//        }
//        
//        if router.canOpenURL(url: locationUrl) {
//          router.openURL(url: locationUrl, completion: nil)
//        } else {
//          router.present(error: CustomError.missingWikiURLScheme)
//        }
      }
        
}
