//
//  OptionsPlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import Foundation
import UIKit


class OptionsPlannerTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    private var colorCell: OptionsTableViewCell?
    let idOptionsPlannerCell = "idOptionsPlannerCell"
    let idOptionsPlannerHeader = "idOptionsPlannerHeader"
    let headerNameArray = ["Date and Time", "Task", "Username", "Color", "Period"]
    
    let cellNameArray = [["Date", "Time"],
                         ["Name", "Priority"],
                         ["User name"],
                         ["", ""],
                         ["Repeat every 7 days"],
    ]
    
    let colorPicker = UIColorPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.bounces = false
        colorPicker.delegate = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "idOptionsPlannerCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsPlannerCell, for: indexPath) as! OptionsTableViewCell
        cell.setUpCellPlanner(arrayOfNames: cellNameArray, indexPath: indexPath)
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
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        navigationController?.navigationBar.topItem?.title = "Options"
        switch indexPath {
        case [0, 0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                print(numberWeekday, date)
            }
        case [0, 1]:
            alertTime(label: cell.nameCellLabel) { (date) in

            }
        case [1, 0]:
            alertCellName(label: cell.nameCellLabel, name: "Task name", placeholder: "Type some name")
        case [1, 1]:
            alertCellName(label: cell.nameCellLabel, name: "Priority", placeholder: "Medium, low...")
        case [2, 0]:
            handleNavigate(viewController: UsersViewController())
        case [3, 0]:
            colorCell = cell
           present(colorPicker, animated: true)
        default:
            print("")
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
