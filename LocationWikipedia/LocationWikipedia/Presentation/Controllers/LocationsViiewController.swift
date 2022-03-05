//
//  LocationsViiewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import UIKit
import Combine

final class LocationsListViewController: UITableViewController, Alertable {
    
    private var viewModel: LocationViewModel!
    private var locations = [Location]()
    private var cancellables: Set<AnyCancellable> = []
    
    private enum LocationError: String {
        case InvalidLocation = "Invalid location, Can't open this location."
    }
    private let cellID = "LocationTableViewCell"
    
    convenience init(viewModel: LocationViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        
        setupRefreshControl()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            refresh()
        }
    }
    
    private func bind() {
        viewModel.$isLoading.sink { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.refreshControl?.beginRefreshing()
                } else {
                    self.refreshControl?.endRefreshing()
                }
            }
        }.store(in: &cancellables)
        
        viewModel.$error.sink { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(message: error)
            }
        }.store(in: &cancellables)
        
        viewModel.$locations.sink { [weak self] locations in
            guard let self = self else { return }
            self.locations = locations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        viewModel.loadLocations()
    }
    
    private func handleAPIResult(_ result: Result<[Location], Error>) {
        switch result {
        case let .success(locations):
            self.locations = locations
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
            
        case let .failure(error):
            showAlert(message: error.localizedDescription)
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
