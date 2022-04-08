//
//  ContactOptionTableViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 08/04/2022.
//

import Foundation
import UIKit

class ContactOptionTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    private var colorCell: OptionsTableViewCell?
    let idOptionsContactCell = "idOptionsContactCell"
    let idOptionsContactHeader = "idOptionsContactHeader"
    let headerNameArray = ["Name", "Phone", "Mail", "Type", "Choose image"]
    
    let cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    let colorPicker = UIColorPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.bounces = false
        colorPicker.delegate = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self,  forHeaderFooterViewReuseIdentifier: idOptionsContactHeader)
    
        tableView.separatorStyle = .none
        title = "Option Planner"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
       
    }
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        cell.setUpCellContact(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 200
        } else {
            return 44
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactHeader) as! HeaderOptionsTableViewCell
        
        header.setUpHeader(arrayOfNames: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0:
            alertCellName(label: cell.nameCellLabel, name: "User name", placeholder: "Steve Jobs")
        case 1:
            alertCellName(label: cell.nameCellLabel, name: "User phone", placeholder: "Enter phone")
        case 2:
            alertCellName(label: cell.nameCellLabel, name: "User mail", placeholder: "Enter mail")
        default:
            return
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        colorCell?.backgroundViewCell.backgroundColor = selectedColor
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        colorCell?.backgroundViewCell.backgroundColor = selectedColor
    }
 
    
    func handleNavigate(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

