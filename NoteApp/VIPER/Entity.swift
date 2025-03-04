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
    
    init(note: String, documentId: String) {
        self.note = note
        self.documentId = documentId
    }
}
