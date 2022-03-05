//
//  SceneDelegate.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let navigationController = UINavigationController()
   
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
    }
    
    func makeRootViewController() -> LocationsListViewController {
        let service = RemoteLocationService(
            url: LocationEndpoint.getLocations.url(
                baseURL: URL(string: "https://raw.githubusercontent.com")!),
            client: URLSessionHTTPClient(session: .shared))
        let viewModel = LocationViewModel(service: service)
        let vc = LocationsListViewController(viewModel: viewModel)
        vc.navigationItem.title = "Locations"
        return vc
    }
}

