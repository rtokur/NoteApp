//
//  Entity.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation

//MARK: Model
class UserNotes: Codable {
    var note: String
    var documentId: String
    var date: String
    
    init(note: String, documentId: String, date: String) {
        self.note = note
        self.documentId = documentId
        self.date = date
    }
}
