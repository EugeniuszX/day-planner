//
//  ColorPlannerTableViewCell.swift
//  dayPlanner
//
//  Created by Evgeniy on 07/04/2022.
//

import UIKit

class ColorPlannerTableViewCell: UITableViewCell {

    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
        }

        self.selectionStyle = .none
        self.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(indexPath: IndexPath) {
       
    }
    
    @objc func handleChangeSwitcher(paramTarget: UISwitch) {
 
    }
    
    func setConstraints() {
       
    }
    
}
