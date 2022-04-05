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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.register(OptionsPlannerTableViewCell.self, forCellReuseIdentifier: "idOptionsPlannerCell")
        tableView.separatorStyle = .none
        title = "Option Planner"
        view.backgroundColor = .white
        
    }
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsPlannerCell, for: indexPath) as! OptionsPlannerTableViewCell
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
