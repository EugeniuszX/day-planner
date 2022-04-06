//
//  OptionsPlannerTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import UIKit

class OptionsPlannerTableViewCell: UITableViewCell {

    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameCellLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitcher: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    let cellNameArray = [["Date", "Time"],
                         ["Name", "Priority"],
                         ["User name"],
                         ["", ""],
                         ["Repeat every 7 days"],
    
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
        }

        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        repeatSwitcher.addTarget(self, action: #selector(handleChangeSwitcher(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(indexPath: IndexPath) {
        nameCellLabel.text = cellNameArray[indexPath.section][indexPath.row]
        
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
        if indexPath == [4,0] {
            repeatSwitcher.isHidden = false
        }
    }
    
    @objc func handleChangeSwitcher(paramTarget: UISwitch) {
 
    }
    
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: -1)
        ])
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
         
        ])
        
        self.addSubview(repeatSwitcher)
        NSLayoutConstraint.activate([
            repeatSwitcher.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitcher.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -16),
         
        ])
    }
    
}
