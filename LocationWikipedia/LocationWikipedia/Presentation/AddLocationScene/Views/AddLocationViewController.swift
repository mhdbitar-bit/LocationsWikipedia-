//
//  AddLocationViewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/7/22.
//

import UIKit

final class AddLocationViewController: UIViewController {

    @IBOutlet var placeField: UITextField!
    @IBOutlet var latField: UITextField!
    @IBOutlet var longField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Location"
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
    }
    
}
