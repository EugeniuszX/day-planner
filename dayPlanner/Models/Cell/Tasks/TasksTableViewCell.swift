//
//  TasksTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 04/04/2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let taskName = UILabel(text: "", font: .avenirNextDemiBold20())
    let taskDescription = UILabel(text: "", font: .avenirNext14())
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    weak var cellTaskDelegate: PressSubmitTaskButtonProtocol?
    var index: IndexPath?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
        }
        
        taskDescription.numberOfLines = 2

        self.selectionStyle = .none
        
        readyButton.addTarget(self, action: #selector(handlePressSubmit), for: .touchUpInside)
    }
    // TODO: Add priority label
    func configure(model: TaskModel) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
        taskName.text = model.taskName
        taskDescription.text = model.taskDescription
//        guard let taskTime = model.taskDate else { return }

        backgroundColor = UIColor().colorFromHex(model.taskColor)
        if model.isTaskDone {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePressSubmit() {
        guard let index = index else { return }
        cellTaskDelegate?.handlePressSubmit(indexPath: index)
    }
    
    func setConstraints() {
        self.contentView.addSubview(readyButton)
        
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
    }
}

