//
//  ContactOptionTableViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 08/04/2022.
//

import Foundation
import UIKit

class ContactOptionsTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    private var colorCell: OptionsTableViewCell?
    private let idOptionsContactCell = "idOptionsContactCell"
    private let idOptionsContactHeader = "idOptionsContactHeader"
    
    private let headerNameArray = ["Name", "Phone", "Mail", "Type", "Choose image"]
    var cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    private var imageIsChanged = false
    var contactModel = ContactModel()
    var isEditModel = false
    var dataImage: Data?
    
    
    let colorPicker = UIColorPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.bounces = false
        colorPicker.delegate = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self,  forHeaderFooterViewReuseIdentifier: idOptionsContactHeader)
    
        tableView.separatorStyle = .none
        title = "Options Contact"
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handlePressSave))
    }
    
    @objc private func handlePressSave() {
        if cellNameArray[0] == "Name" || cellNameArray[3] == "Type" {
            alertSuccessful(title: "Error", message: "Required fields: Name and Type")
        } else {
            setImageModel()
            setModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            
            cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
            alertSuccessful(title: "Success", message: nil)
            tableView.reloadData()
        }
    }
    
    private func setModel() {
        contactModel.contactName = cellNameArray[0]
        contactModel.contactPhone = cellNameArray[1]
        contactModel.contactMail = cellNameArray[2]
        contactModel.contactType = cellNameArray[3]
        contactModel.contactImage = dataImage
    }
    
    func setImageModel() {
        if imageIsChanged {
            
            let cell =  tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else {return}
            dataImage = imageData
            
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            dataImage = nil
        }
    }
    
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        if isEditModel == false {
            cell.setUpCellContact(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactModel.contactImage, let image = UIImage(data: data) {
            cell.setUpCellContact(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.setUpCellContact(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }       
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 200
        } else {
            return 44
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactHeader) as! HeaderOptionsTableViewCell
        
        header.setUpHeader(arrayOfNames: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0:
            alertCellName(label: cell.nameCellLabel, name: "User name", placeholder: "Steve Jobs") { text in
//                self.contactModel.contactName = text
                self.cellNameArray[0] = text
                
            }
        case 1:
            alertCellName(label: cell.nameCellLabel, name: "User phone", placeholder: "Enter phone") { text in
//                self.contactModel.contactPhone = text
                self.cellNameArray[1] = text
            }
        case 2:
            alertCellName(label: cell.nameCellLabel, name: "User mail", placeholder: "Enter mail") { text in
//                self.contactModel.contactMail = text
                self.cellNameArray[2] = text
            }
        case 3:
            alertOfUsers(label: cell.nameCellLabel) { (type) in
//                self.contactModel.contactType = type
                self.cellNameArray[3] = type
            }
        case 4:
            alertPhotoCamera { source in
                self.chooseImagePicker(source: source)
                
            }
        default:
            return
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        colorCell?.backgroundViewCell.backgroundColor = selectedColor
    }

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        colorCell?.backgroundViewCell.backgroundColor = selectedColor
    }
 
    func handleNavigate(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ContactOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4, 0]) as! OptionsTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
