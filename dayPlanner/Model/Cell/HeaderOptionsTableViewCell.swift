//
//  HeaderOptionsPlannerTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 05/04/2022.
//

import Foundation
import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "HEADER", font: .avenirNext14())
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier:  reuseIdentifier)
        headerLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader(arrayOfNames: [String], section: Int) {
        headerLabel.text = arrayOfNames[section]
    }
    
    func setConstraints() {
       
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
}
