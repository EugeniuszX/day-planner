//
//  OptionsPlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import Foundation
import UIKit
import SwiftUI

class OptionsPlannerTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    
    let idOptionsPlannerCell = "idOptionsPlannerCell"
    let idOptionsPlannerHeader = "idOptionsPlannerHeader"
    let headerNameArray = ["Date and Time", "Task", "Username", "Color", "Period"]
    
    
    let colorPickerViewController: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        
        return colorPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        colorPickerViewController.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.bounces = false
        tableView.register(OptionsPlannerTableViewCell.self, forCellReuseIdentifier: "idOptionsPlannerCell")
        tableView.register(HeaderOptionsTableViewCell.self,  forHeaderFooterViewReuseIdentifier: idOptionsPlannerHeader)
    
        tableView.separatorStyle = .none
        title = "Option Planner"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
       
    }
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsPlannerCell, for: indexPath) as! OptionsPlannerTableViewCell
        cell.setUpCell(indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsPlannerHeader) as! HeaderOptionsTableViewCell
        
        header.setUpHeader(arrayOfNames: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsPlannerTableViewCell
        navigationController?.navigationBar.topItem?.title = "Options"
        switch indexPath {
        case [0, 0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                print(numberWeekday, date)
            }
        case [0, 1]:
            alertTime(label: cell.nameCellLabel) { (date) in
                print("date =>", date)
            }
        case [1, 0]:
            alertcellName(label: cell.nameCellLabel, name: "Task name", placeholder: "Type some name")
        case [1, 1]:
            alertcellName(label: cell.nameCellLabel, name: "Priority", placeholder: "Medium, low...")
        case [2, 0]:
            handleNavigate(viewController: UsersViewController())
        case [3, 0]:
            present(colorPickerViewController, animated: true)
        default:
            print("SOmethings")
        }
    }
    
    func handleSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        
    }
    
    func handleNavigate(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
