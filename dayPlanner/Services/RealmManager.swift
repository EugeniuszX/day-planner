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
}
