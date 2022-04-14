//
//  ContactsTableViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 08/04/2022.
//

import Foundation
import UIKit
import RealmSwift

class ContactsTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    let localRealm = try! Realm()
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    
    var contactsArray: Results<ContactModel>!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
    
        tableView.separatorStyle = .singleLine
        title = "Contacts"
        contactsArray = localRealm.objects(ContactModel.self)
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlePressAddButton))
    }
    @objc func handlePressAddButton() {
        let contactsOption = ContactOptionsTableViewController()
        navigationController?.pushViewController(contactsOption, animated: true) 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")

    }
}
