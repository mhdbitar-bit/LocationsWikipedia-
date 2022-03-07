//
//  AddLocationViewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/7/22.
//

import UIKit
import Combine

protocol AddLocationDelegate {
    func addLocation(location: Location)
}

final class AddLocationViewController: UIViewController, Alertable {
    
    @IBOutlet var placeField: UITextField!
    @IBOutlet var latField: UITextField!
    @IBOutlet var longField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var delegate: AddLocationDelegate?
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: AddLocationViewModel!
    let INVALID_FIELDS = "Invalid fields, Please enter valid data"
    
    convenience init(viewModel: AddLocationViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        placeField.delegate = self
        latField.delegate = self
        longField.delegate = self
                
        bind()
    }
    
    private func bind() {
        bindTextFields()
        bindValidation()
    }
    
    private func bindTextFields() {
        placeField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
        
        latField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.latitude, on: viewModel)
            .store(in: &cancellables)
        
        longField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.longitude, on: viewModel)
            .store(in: &cancellables)
    }
    
    private func bindValidation() {
        viewModel.isInputValid
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: addButton)
            .store(in: &cancellables)
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        addNew()
    }
    
    private func addNew() {
        if let latitude = Double(viewModel.latitude), let longitude = Double(viewModel.longitude) {
            let location = Location(
                name: viewModel.name,
                coordinators: (latitude: latitude, longitude: longitude))
            delegate?.addLocation(location: location)
        } else {
            showAlert(message: INVALID_FIELDS)
        }
    }
}

extension AddLocationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case placeField:
            latField.becomeFirstResponder()
        case latField:
            longField.becomeFirstResponder()
        case longField:
            textField.resignFirstResponder()
            addNew()
        default: break
        }
        
        return true
    }
}
