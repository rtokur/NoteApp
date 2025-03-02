//
//  Entity.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation

//MARK: Model
class UserNotes: Codable {
    var noteId: String
    var note: String
    var noteTitle: String
    
    init(noteId: String,
         note: String,
         noteTitle: String) {
        self.noteId = noteId
        self.note = note
        self.noteTitle = noteTitle
    }
}
