//
//  TaskOptionTableView.swift
//  dayPlanner
//
//  Created by Evgeniy on 07/04/2022.
//

import Foundation
import UIKit

class TaskOptionsTableView: UITableViewController, UIColorPickerViewControllerDelegate {
    private var colorCell: OptionsTableViewCell?
    let idOptionsTaskCell = "idOptionsTaskCell"
    let idOptionsTasksHeader = "idOptionsTasksHeader"
    let headerNameArray = ["Date and Time", "Task", "Color"]
    let cellNameArray = [["Date"],[ "Name", "Priority"], [""]]
    let colorPicker = UIColorPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.bounces = false
        colorPicker.delegate = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self,  forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
    
        tableView.separatorStyle = .none
        title = "Option Tasks"
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
       
    }
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 1
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTaskCell, for: indexPath) as! OptionsTableViewCell
        cell.setUpCellTasks(nameArray: cellNameArray,indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        
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
        
            }
        case [1, 0]:
            alertCellName(label: cell.nameCellLabel, name: "Name", placeholder: "Enter task name") { text in
                
            }
        case [1,1]:
            alertCellName(label: cell.nameCellLabel, name: "Priority", placeholder: "Medium, low...") { text in
                
            }
        case [2,0]:
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
