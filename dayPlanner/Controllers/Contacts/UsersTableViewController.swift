//
//  UsersViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 06/04/2022.
//
import Foundation
import RealmSwift
import UIKit

class UsersTableViewController: UITableViewController {
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private let userId = "userId"


override func viewDidLoad() {
    super.viewDidLoad()
   
    title = "Users"
    view.backgroundColor = .white
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: userId)

    contactsArray = localRealm.objects(ContactModel.self).filter("contactType = 'User'")
}
    private func setUsers(user: String) {
      let plannerOptions = self.navigationController?.viewControllers[1] as? PlannerOptionsTableViewController
        plannerOptions?.plannerModel.plannerUser = user
        plannerOptions?.cellNameArray[2][0] = user
        plannerOptions?.tableView.reloadRows(at: [[2,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userId, for: indexPath) as! ContactsTableViewCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model  = contactsArray[indexPath.row]
        setUsers(user: model.contactName)
    }
}

