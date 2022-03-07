//
//  AddLocationViewController.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/7/22.
//

import UIKit
import Combine

final class AddLocationViewController: UIViewController {
    
    @IBOutlet var placeField: UITextField!
    @IBOutlet var latField: UITextField!
    @IBOutlet var longField: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: AddLocationViewModel!
    
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
        
        // Listen for keybaord events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        bind()
    }
    
    deinit {
        // Stop listing for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func bind() {
        bindTextFields()
    }
    
    private func bindTextFields() {
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
        // TOD add values into tableView
    }
}

// MARK: - Keyboard functions

extension AddLocationViewController {
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name ==  UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if scrollConstraint.constant <= 0 {
                UIView.animate(withDuration: 0.3) {
                    self.scrollConstraint.constant = 0
                    self.scrollConstraint.constant += keyboardSize.height - 100
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if scrollConstraint.constant != 0 {
                UIView.animate(withDuration: 0.3) {
                    self.scrollConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
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
