//
//  ContactModel.swift
//  dayPlanner
//
//  Created by Evgeniy on 14/04/2022.
//

import RealmSwift

class ContactModel: Object {
    @Persisted var contactName = "Unknown"
    @Persisted var contactPhone = "Unknown"
    @Persisted var contactMail = "Unknown"
    @Persisted var contactType = "Unknown"
    @Persisted var contactImage: Data?
}
