//
//  PlannerTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 03/04/2022.
//

import UIKit

class PlannerTableViewCell: UITableViewCell {
    let taskName = UILabel(text: "", font: .avenirNextDemiBold20())
    let userName = UILabel(text: "", font: .avenirNextDemiBold14(), alignment: .right)
    let taskTime = UILabel(text: "", font: .avenirNextDemiBold20())
    let taskPriorityLabel = UILabel(text: "Priority:", font: .avenirNext14(), alignment: .right)
    let taskPriority = UILabel(text: "", font: .avenirNext14())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
        }

        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: PlannerModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        taskName.text = model.plannerName
        userName.text = model.plannerUser
        taskTime.text = dateFormatter.string(from: model.plannerTime)
        taskPriority.text = model.plannerPriority
        backgroundColor = UIColor().colorFromHex(model.plannerColor)
    }
    
    func setConstraints() {
        let topStackView = UIStackView(arrangedSubviews: [taskName, userName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        

        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskTime)
        NSLayoutConstraint.activate([
            taskTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            taskTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskTime.widthAnchor.constraint(equalToConstant: 100),
            taskTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        let bottomStackView = UIStackView(arrangedSubviews: [taskPriorityLabel,taskPriority ], axis: .horizontal, spacing: 5, distribution: .fillProportionally )
        
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: taskTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}
