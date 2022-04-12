//
//  TasksViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 01/04/2022.
//


import FSCalendar
import RealmSwift
import SwiftUI
import UIKit


class TasksViewController: UIViewController {
    let localRealm = try! Realm()
    var tasksArray: Results<TaskModel>!
    var calendarHeightConstraint: NSLayoutConstraint!
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let toggleVisibleButton: UIButton = {
     let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2365458608, green: 0.2365458608, blue: 0.2365458608, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idTasksCell = "idTasksCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Tasks"
        view.backgroundColor = .white
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        tasksOnDay(date: Date())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: idTasksCell)
        
        setConstraints()
        swipeActions()
        
        toggleVisibleButton.addTarget(self, action: #selector(handleToggleVisibleCalendar), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlePressAddButton))
    }
    
    @objc func handlePressAddButton() {
        let tasksOption = TaskOptionsTableView()
        navigationController?.pushViewController(tasksOption, animated: true)
    }
    
    @objc func handleToggleVisibleCalendar() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            toggleVisibleButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            toggleVisibleButton.setTitle("Open calendar", for: .normal)
        }
    }
    
    // MARK: SwipeGestureRecognizer
    
    func swipeActions() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    @objc func handleSwipe() {
        handleToggleVisibleCalendar()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource


extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTasksCell, for: indexPath) as! TasksTableViewCell
        cell.cellTaskDelegate = self
        cell.index = indexPath
        let model = tasksArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func tasksOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else {  return }
        let compound = NSCompoundPredicate(format: "taskWeekday = \(weekday)")
        tasksArray = localRealm.objects(TaskModel.self).filter(compound)
        tableView.reloadData()
    }
}

// MARK: PressSubmitTaskButtonProtocol

extension TasksViewController: PressSubmitTaskButtonProtocol {
    func handlePressSubmit(indexPath: IndexPath) {
        print("tap")
    }
    
    
}



// MARK: FSCalendarDataSource, FSCalendarDelegate


extension TasksViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasksOnDay(date: date)
    }
}

// MARK: SetConstraints

extension TasksViewController {
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

