//
//  PlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 01/04/2022.
//

import Foundation
import UIKit
import SwiftUI
import FSCalendar


class PlannerViewController: UIViewController {
    private var calendarHeightConstraint: NSLayoutConstraint!
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private let toggleVisibleButton: UIButton = {
     let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2365458608, green: 0.2365458608, blue: 0.2365458608, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
   private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idPlannerCell = "idPlannerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Planner"
        view.backgroundColor = .white
        
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlannerTableViewCell.self, forCellReuseIdentifier: idPlannerCell)
        
        setConstraints()
        swipeActions()
        
        toggleVisibleButton.addTarget(self, action: #selector(handleToggleVisibleCalendar), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlePressAddButton))
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        }
    }
    
    @objc private func handlePressAddButton() {
        let plannerOption = PlannerOptionsTableViewController()
        navigationController?.pushViewController(plannerOption, animated: true)
    }
    
    @objc private func handleToggleVisibleCalendar() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            toggleVisibleButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            toggleVisibleButton.setTitle("Open calendar", for: .normal)
        }
    }
    
    // MARK: SwipeGestureRecognizer
    
    private func swipeActions() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    @objc private func handleSwipe() {
        handleToggleVisibleCalendar()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource


extension PlannerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idPlannerCell, for: indexPath) as! PlannerTableViewCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


// MARK: FSCalendarDataSource, FSCalendarDelegate


extension PlannerViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}

// MARK: SetConstraints

extension PlannerViewController {
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint.init(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(toggleVisibleButton)
        
        NSLayoutConstraint.activate([
            toggleVisibleButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            toggleVisibleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            toggleVisibleButton.widthAnchor.constraint(equalToConstant: 100),
            toggleVisibleButton.heightAnchor.constraint(equalToConstant: 20)
       
        ])
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: toggleVisibleButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
