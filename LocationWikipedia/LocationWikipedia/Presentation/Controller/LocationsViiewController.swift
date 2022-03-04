//
//  LocationsViiewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import UIKit

final class LocationsListViewController: UITableViewController {
    
    let cellID = "LocationTableViewCell"
    var locations = [LocationDTO]()
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
        refreshControl?.beginRefreshing()
        service?.getLocations(completion: handleAPIResult)
    }
    
    private func handleAPIResult(_ result: Result<[LocationDTO], Error>) {
        switch result {
        case let .success(locations):
            self.locations = locations
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            
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
        let location = locations[indexPath.row]
        // TODO Deeplink Wikipedia
    }
}
