//
//  TaskModel.swift
//  dayPlanner
//
//  Created by Evgeniy on 10/04/2022.
//

import RealmSwift

class TaskModel: Object {
    
    @Persisted var taskDate = Date()
    @Persisted var taskName = ""
    @Persisted var taskDescription: String = ""
    @Persisted var plannerPriority: String = ""
    @Persisted var plannerColor: String = "FFFFFF"

    
}
