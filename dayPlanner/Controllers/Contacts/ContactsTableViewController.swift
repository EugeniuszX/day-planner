//
//  ContactsTableViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 08/04/2022.
//

import Foundation
import UIKit

class ContactsTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    let idContactsCell = "idContactsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.bounces = false
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
    
        tableView.separatorStyle = .singleLine
        title = "Contacts"
        
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlePressAddButton))
    }
    @objc func handlePressAddButton() {
        let contactsOption = ContactOptionTableViewController()
        navigationController?.pushViewController(contactsOption, animated: true) 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")

    }
}
