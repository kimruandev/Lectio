//
//  Book.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import Foundation

struct Book: Identifiable, Codable {
    let id: UUID
    let title: String
    let author: String
    let pageCount: Int
    let chapterCount: Int?
    let genres: [String]
    let synopsis: String
    let coverURL: URL?
    
    // For API responses, we might need to map different keys
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case pageCount
        case chapterCount
        case genres
        case synopsis
        case coverURL
    }
}
