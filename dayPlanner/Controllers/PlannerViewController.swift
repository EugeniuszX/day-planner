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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Planner"
        view.backgroundColor = .white
        
        
        calendar.delegate = self
        calendar.dataSource = self
        
        setConstraints()
        
        toggleVisibleButton.addTarget(self, action: #selector(handleToggleVisibleCalendar), for: .touchUpInside)
    }
    
    @objc func handleToggleVisibleCalendar() {
        print("Tap")
    }

}

// MARK: FSCalendarDataSource, FSCalendarDelegate


extension PlannerViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
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
    }
}
