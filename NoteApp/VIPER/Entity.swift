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
    var type: String
    
    init(note: [[String: Any]], documentId: String, date: String, type: String) {
        self.note = try! JSONSerialization.data(withJSONObject: note, options: .prettyPrinted).base64EncodedString()
        self.documentId = documentId
        self.date = date
        self.type = type
    }
    
    func getNote() -> [[String: Any]]? {
            guard let noteData = Data(base64Encoded: note) else { return nil }
            return try? JSONSerialization.jsonObject(with: noteData, options: []) as? [[String: Any]]
    }
}
