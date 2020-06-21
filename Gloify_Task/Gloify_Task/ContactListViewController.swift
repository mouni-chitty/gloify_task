//
//  ContactListViewController.swift
//  Gloify_Task
//
//  Created by Mounika K on 21/06/20.
//  Copyright © 2020 Mounika K. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ContactDetailProtocol {
    
    private let contactsViewModel =  ContactsViewModel()
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsViewModel.getContacts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsViewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath) as! ContactTableViewCell
        contactCell.localContact = contactsViewModel.getLocalContactFrom(indexPath.row)
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contexualAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.contactsViewModel.deleteContactAt(indexPath.row)
            self.contactsTableView.reloadData()
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [contexualAction])
        return swipeActionConfig
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: indexPath.row)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "detail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactDetailVC = segue.destination as! ContactDetailViewController
        
        if let index = sender as? Int {
            contactDetailVC.index = index
            contactDetailVC.localContact = contactsViewModel.getLocalContactFrom(index)
        }
        contactDetailVC.contactDetailProtocol = self
    }
    
    func saveContact(_ localContact: LocalContact, at index: Int?) {
        if let updateIndex = index {
            contactsViewModel.updateContact(localContact, at: updateIndex)
        } else {
            contactsViewModel.addContact(localContact)
        }
        self.contactsTableView.reloadData()
    }
    
}
