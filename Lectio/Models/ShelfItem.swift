//
//  ShelfItem.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import Foundation

struct ShelfItem: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let bookId: UUID
    var status: ReadingStatus
    var rating: Int? // 1-5
    var notes: String?
    var highlights: [Highlight]?
    let dateAdded: Date
    var dateCompleted: Date?
    
    enum ReadingStatus: String, Codable, CaseIterable {
        case wantToRead = "Quero Ler"
        case reading = "Lendo"
        case read = "Lido"
    }
    
    struct Highlight: Identifiable, Codable {
        let id: UUID
        let text: String
        let location: String? // page or chapter
        let dateCreated: Date
    }
}

extension ShelfItem {
    var bookTitle: String {
        // In real app, we'd have a reference to the book
        return "Título do Livro"
    }

    var bookAuthor: String {
        return "Autor do Livro"
    }

    var pageCount: Int {
        // In real app, we'd get this from the book
        return 0
    }

    var chapterCount: Int? {
        // In real app, we'd get this from the book
        return nil
    }

    var genres: [String] {
        // In real app, we'd get this from the book
        return []
    }

    var synopsis: String {
        // In real app, we'd get this from the book
        return ""
    }
}
