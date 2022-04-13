//
//  TaskModel.swift
//  dayPlanner
//
//  Created by Evgeniy on 10/04/2022.
//

import RealmSwift

class TaskModel: Object {
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescription: String = "Unknown"
    @Persisted var taskPriority: String = ""
    @Persisted var taskColor: String = "FFFFFF"
    @Persisted var taskWeekday: Int = 1
    @Persisted var isTaskDone: Bool = false
}
