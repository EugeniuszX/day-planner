//
//  RealmManager.swift
//  dayPlanner
//
//  Created by Evgeniy on 09/04/2022.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {
        
    }
    
    let localRealm = try! Realm()
    
    func savePlannerModel(model: PlannerModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func saveTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    func saveContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deletePlannerModel(model: PlannerModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    func deleteTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    func deleteContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    func updateContactModel(model: ContactModel, nameArray: [String], imageData: Data?) {
        try! localRealm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactMail = nameArray[2]
            model.contactType = nameArray[3]
            model.contactImage = imageData
        }
    }
    func updateReadyButtonTaskModel(task: TaskModel, bool: Bool) {
        try! localRealm.write {
            task.isTaskDone = bool
        }
    }
    
}
