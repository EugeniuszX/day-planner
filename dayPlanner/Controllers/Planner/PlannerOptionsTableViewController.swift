//
//  OptionsPlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import Foundation
import UIKit


class PlannerOptionsTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    private var colorCell: OptionsTableViewCell?
   
    private let idOptionsPlannerCell = "idOptionsPlannerCell"
    private let idOptionsPlannerHeader = "idOptionsPlannerHeader"
    let headerNameArray = ["Date and Time", "Task", "Username", "Color", "Period"]
    
    var cellNameArray = [["Date", "Time"],
                         ["Name", "Priority"],
                         ["User name"],
                         ["", ""],
                         ["Repeat every 7 days"],
    ]
    var plannerModel = PlannerModel()
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
        title = "Options Planner"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handlePressSaveButton))
    }
    @objc private func handlePressSaveButton() {
        
        if plannerModel.plannerDate == nil || plannerModel.plannerTime == nil || plannerModel.plannerName == "Unknown" {
            alertSuccessful(title: "Error", message: "Required fields: date, time, name")
            
            return
        }
        
        
        RealmManager.shared.savePlannerModel(model: plannerModel)
        plannerModel = PlannerModel()
        cellNameArray[2][0] = "User name"
        alertSuccessful(title: "Success", message: nil)
        tableView.reloadRows(at: [[0,0],[0,1], [1,0],[1,1],[2,0],[3,0],[3,1], [4 ,0]], with: .fade)
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
        cell.handleSwitchDelegate = self
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
                self.plannerModel.plannerDate = date
                self.plannerModel.plannerWeekday = numberWeekday
            }
        case [0, 1]:
            alertTime(label: cell.nameCellLabel) { (time) in
                self.plannerModel.plannerTime = time
            }
        case [1, 0]:
            alertCellName(label: cell.nameCellLabel, name: "Task name", placeholder: "Type some name") { name in
                self.plannerModel.plannerName = name
            }
        case [1, 1]:
            alertCellName(label: cell.nameCellLabel, name: "Priority", placeholder: "Medium, low...") { priority in
                self.plannerModel.plannerPriority = priority
            }
        case [2, 0]:
            handleNavigate(viewController: UsersTableViewController())
        case [3, 0]:
            colorCell = cell
           present(colorPicker, animated: true)
        default:
            print("")
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        let hexSelectedColor = UIColor().hexStringFromColor(color: selectedColor)
        self.plannerModel.plannerColor = hexSelectedColor
        colorCell?.backgroundViewCell.backgroundColor = selectedColor
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        let hexSelectedColor = UIColor().hexStringFromColor(color: selectedColor)
        self.plannerModel.plannerColor = hexSelectedColor
        colorCell?.backgroundViewCell.backgroundColor = selectedColor
    }
 
    
    func handleNavigate(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension PlannerOptionsTableViewController: HandleSwitchProtocol {
    func handleSwitch(value: Bool) {
        plannerModel.plannerRepeat = value
    }
}
