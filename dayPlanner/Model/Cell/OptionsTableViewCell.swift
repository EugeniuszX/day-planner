//
//  OptionsPlannerTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    func setUpCellPlanner(arrayOfNames: [[String]], indexPath: IndexPath) {
        nameCellLabel.text = arrayOfNames[indexPath.section][indexPath.row]
        
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
        if indexPath == [4,0] {
            repeatSwitcher.isHidden = false
        }
    }
    
    func setUpCellTasks(nameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
    }
    
    
    func setUpCellContact(nameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        if indexPath.section == 4 {
            backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus")
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
