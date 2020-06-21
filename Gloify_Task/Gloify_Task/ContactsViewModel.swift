//
//  ContactsViewModel.swift
//  Gloify_Task
//
//  Created by Mounika K on 21/06/20.
//  Copyright © 2020 Mounika K. All rights reserved.
//

import UIKit
import CoreData


struct LocalContact {
    var name : String?
    var number : String?
    var email : String?
}

class ContactsViewModel {
    
    var contacts : [Contact] = []
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getContacts() {
        let fetchRequest : NSFetchRequest<Contact> = Contact.fetchRequest()
        do {
            self.contacts = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addContact(_ newContact : LocalContact ) {
        
        let contact = Contact(context: context)
        
        contact.name = newContact.name
        contact.number = newContact.number
        contact.email = newContact.email
        
        do {
            try context.save()
            contacts.append(contact)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func updateContact(_ localContact: LocalContact, at index: Int) {
        
        let contact = contacts[index]
        
        contact.name = localContact.name
        contact.number = localContact.number
        contact.email = localContact.email
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteContactAt(_ index: Int) {
        context.delete(contacts[index])
    }
    
    
    func getLocalContactFrom(_ index : Int) -> LocalContact {
        let detail = contacts[index]
        return LocalContact(name: detail.name, number: detail.number, email: detail.email)
    }
    
}







