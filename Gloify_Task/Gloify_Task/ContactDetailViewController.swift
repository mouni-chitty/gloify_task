//
//  ContactDetailViewController.swift
//  Gloify_Task
//
//  Created by Mounika K on 21/06/20.
//  Copyright © 2020 Mounika K. All rights reserved.
//

import UIKit

protocol ContactDetailProtocol {
    func saveContact(_ localContact: LocalContact, at index: Int?)
}

class ContactDetailViewController: UIViewController, UITextFieldDelegate {
    
    var index: Int?
    var localContact: LocalContact?
    var contactDetailProtocol: ContactDetailProtocol?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateDetails()
    }
    
    private func populateDetails() {
        nameTextField.text = localContact?.name
        numberTextField.text = localContact?.number
        emailTextField.text = localContact?.email
    }
    
    
    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        
        if nameTextField.text?.isEmpty ?? true {
            showAlert(title: "Name", message: "Please enter your name")
            return
        }
        if numberTextField.text?.isEmpty ?? true {
            showAlert(title: "Number", message: "Please enter your number")
            return
        }
        if emailTextField.text?.isEmpty ?? true {
            showAlert(title: "Email", message: "Please enter your email")
            return
        }
        
        let localContact = LocalContact(name: nameTextField.text, number: numberTextField.text, email: emailTextField.text)
        contactDetailProtocol?.saveContact(localContact, at: index)
        navigationController?.popViewController(animated: true)
        
    }
    
    func showAlert( title:String , message:String ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAlert)
        present(alertController, animated: true, completion: nil)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            numberTextField.becomeFirstResponder()
        } else if textField == numberTextField {
            emailTextField.becomeFirstResponder()
        } else {
            emailTextField.resignFirstResponder()
        }
        return true
        
    }
   
}
