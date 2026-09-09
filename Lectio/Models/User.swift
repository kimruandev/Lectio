//
//  User.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    let avatarURL: URL?
    let email: String
    let readerProfile: ReaderProfile
    var totalPoints: Int
    var badges: [Badge]
    let dateCreated: Date
    
    enum ReaderProfile: String, Codable, CaseIterable {
        case fantasy = "Fantasia"
        case romance = "Romance"
        case sciFi = "Ficção Científica"
        case general = "Geral"
    }
    
    struct Badge: Identifiable, Codable {
        let id: UUID
        let name: String
        let description: String
        let iconName: String
        let earnedDate: Date
    }
}
