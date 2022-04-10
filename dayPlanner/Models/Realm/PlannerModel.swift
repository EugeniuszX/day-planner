//
//  PlannerModel.swift
//  dayPlanner
//
//  Created by Evgeniy on 09/04/2022.
//

import RealmSwift

class PlannerModel: Object {
    
    @Persisted var plannerDate = Date()
    @Persisted var plannerTime = Date()
    @Persisted var plannerName: String = "Unknown"
    @Persisted var plannerPriority: String = "Unknown"
    @Persisted var plannerUser: String = "Melber17"
    @Persisted var plannerColor: String = "FFFFFF"
    @Persisted var plannerRepeat: Bool = true
    @Persisted var plannerWeekday: Int = 1
    
}
