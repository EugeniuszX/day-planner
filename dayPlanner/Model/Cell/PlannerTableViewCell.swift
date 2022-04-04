//
//  PlannerTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 03/04/2022.
//

import UIKit

class PlannerTableViewCell: UITableViewCell {
    
    let taskName: UILabel = {
       let label = UILabel()
        label.text = "Go to shopping"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        
        return label
    }()
    
    let userName: UILabel = {
       let label = UILabel()
        label.text = "Melber17"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(taskName)
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.widthAnchor.constraint(equalToConstant: self.frame.width / 2 - 10),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            userName.widthAnchor.constraint(equalToConstant: self.frame.width / 2 - 10),
            userName.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}
