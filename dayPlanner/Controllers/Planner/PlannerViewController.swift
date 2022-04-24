//
//  PlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 01/04/2022.
//

import RealmSwift
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
    
    private let toggleVisibleButton: UIButton = UIButton().createSwitchButton()
  
    
   private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    var plannerArray: Results<PlannerModel>!
    
    private let idPlannerCell = "idPlannerCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
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
        plannerOnDay(date: Date())
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
    private func plannerOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else {  return }
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "plannerWeekday = \(weekday) AND plannerRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "plannerRepeat = false AND plannerDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        plannerArray = localRealm.objects(PlannerModel.self).filter(compound).sorted(byKeyPath: "plannerTime")
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource


extension PlannerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plannerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idPlannerCell, for: indexPath) as! PlannerTableViewCell
        let model = plannerArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = plannerArray[indexPath.row]
        
        let handleDeleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deletePlannerModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [handleDeleteAction])
    }
}


// MARK: FSCalendarDataSource, FSCalendarDelegate


extension PlannerViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        plannerOnDay(date: date)
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
            toggleVisibleButton.heightAnchor.constraint(equalToConstant: 48),
            toggleVisibleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toggleVisibleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
