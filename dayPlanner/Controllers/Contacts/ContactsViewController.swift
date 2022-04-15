//
//  ContactsTableViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 08/04/2022.
//

import Foundation
import UIKit
import RealmSwift

class ContactsViewController: UIViewController, UIColorPickerViewControllerDelegate {
  
    private let segmentedControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["Users", "Strangers"])
        segmentedControll.selectedSegmentIndex = 0
        return segmentedControll
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.separatorStyle = .singleLine
        
        return tableView
    }()
    
    let localRealm = try! Realm()
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    
    var contactsArray: Results<ContactModel>!
    var filterredArray: Results<ContactModel>!
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        
        return text.isEmpty
    }
    
    var isSearchBarActive: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        title = "Contacts"
        contactsArray = localRealm.objects(ContactModel.self).filter("contactType == 'User'")
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlePressAddButton))
            
        segmentedControll.addTarget(self, action: #selector(handleChangeSegment), for: .valueChanged)
        
        setContraints()
        
    }
    
    @objc func handleChangeSegment() {
        if segmentedControll.selectedSegmentIndex == 0 {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactType == 'User'")
            tableView.reloadData()
        } else {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactType == 'Teacher'")
            tableView.reloadData()
        }
    }
    
    @objc func handlePressAddButton() {
        let contactsOption = ContactOptionsTableViewController()
        navigationController?.pushViewController(contactsOption, animated: true) 
    }


}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return (isSearchBarActive ? filterredArray.count : contactsArray.count)
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        
         let model = (isSearchBarActive ? filterredArray[indexPath.row] : contactsArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ContactsViewController {
    private func setContraints() {
        let stackView = UIStackView(arrangedSubviews: [segmentedControll, tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}


extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        handleFilterContacts(searchController.searchBar.text!)
    }
    private func handleFilterContacts(_ searchText: String) {
        filterredArray = contactsArray.filter("contactName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
}
