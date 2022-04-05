//
//  OptionsPlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import Foundation
import UIKit
import SwiftUI

class OptionsPlannerTableViewController: UITableViewController {
    
    let idOptionsPlannerCell = "idOptionsPlannerCell"
    let idOptionsPlannerHeader = "idOptionsPlannerHeader"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.register(OptionsPlannerTableViewCell.self, forCellReuseIdentifier: "idOptionsPlannerCell")
        tableView.register(HeaderOptionsPlannerTableViewCell.self,  forHeaderFooterViewReuseIdentifier: idOptionsPlannerHeader)
    
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsPlannerHeader) as! HeaderOptionsPlannerTableViewCell
        
        header.setUpHeader(section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
