//
//  AddBookViewModel.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI
import Combine

class AddBookViewModel: ObservableObject {
    @Published var title = ""
    @Published var author = ""
    @Published var pageCount = 100
    @Published var chapterCount = 0
    @Published var genres = ""
    @Published var synopsis = ""
    @Published var initialStatus: ShelfItem.ReadingStatus = .wantToRead
    
    var isValid: Bool {
        !title.isEmpty && !author.isEmpty && pageCount > 0
    }
}
