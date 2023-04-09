//
//  ContactModel.swift
//  mySchedule
//
//  Created by Grigore on 08.04.2023.
//

import Foundation
import RealmSwift

class ContactModel: Object {
    
    @Persisted var contactName = "Unknown"
    @Persisted var contactPhone = "Unknown"
    @Persisted var contactMail = "Unknown"
    @Persisted var contactType = "Unknown"
    @Persisted var contactImages: Data?

}
