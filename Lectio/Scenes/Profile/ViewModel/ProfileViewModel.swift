//
//  ProfileViewModel.swift
//  Lectio
//
import Combine
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedProfile: User.ReaderProfile = .general
    @Published var notificationsEnabled = true
    
    var booksReadCount: Int {
        // In real app, this would come from shelf items with status .read
        return 5 // Mock data
    }
    
    var currentStreak: Int {
        // In real app, calculate from reading events
        return 7 // Mock data
    }
    
    init() {
        // Create a mock user
        self.user = User(id: UUID(),
                       name: "João Silva",
                       avatarURL: nil,
                       email: "joao@email.com",
                       readerProfile: .fantasy,
                       totalPoints: 1250,
                       badges: [
                        User.Badge(id: UUID(),
                                 name: "Cavaleiro das 1000 páginas",
                                 description: "Leu 1000 páginas",
                                 iconName: "shield.fill",
                                 earnedDate: Date().addingTimeInterval(-86400 * 10)),
                        User.Badge(id: UUID(),
                                 name: "Leitor Assíduo",
                                 description: "Leu por 7 dias consecutivos",
                                 iconName: "flame.fill",
                                 earnedDate: Date().addingTimeInterval(-86400 * 2))
                       ],
                       dateCreated: Date().addingTimeInterval(-86400 * 30))
    }
}
