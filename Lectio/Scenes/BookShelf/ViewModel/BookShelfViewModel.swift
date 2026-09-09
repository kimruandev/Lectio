//
//  BookShelfViewModel.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import Combine
import Foundation

class BookShelfViewModel: ObservableObject {
    @Published var shelfItems: [ShelfItem] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Create mock data
            let userId = UUID()
            
            let book1 = Book(id: UUID(),
                           title: "O Hobbit",
                           author: "J.R.R. Tolkien",
                           pageCount: 310,
                           chapterCount: 19,
                           genres: ["Fantasia", "Aventura"],
                           synopsis: "Bilbo Bolseiro é um hobbit que leva uma vida tranquila até que o mago Gandalf chega com um grupo de anões para recrutá-lo em uma aventura.",
                           coverURL: nil)
            
            let book2 = Book(id: UUID(),
                           title: "Dom Casmurro",
                           author: "Machado de Assis",
                           pageCount: 256,
                           chapterCount: 108,
                           genres: ["Romance", "Clássico"],
                           synopsis: "Bento Santiago, acusado de traição pela esposa Capitu,Recorda sua juventude e seu amor por Capitu, refletindo sobre ciúme, memória e a natureza da verdade.",
                           coverURL: nil)
            
            let shelfItem1 = ShelfItem(id: UUID(),
                                     userId: userId,
                                     bookId: book1.id,
                                     status: .read,
                                     rating: 5,
                                     notes: "Uma das melhores histórias de fantasia já escritas.",
                                     highlights: [],
                                     dateAdded: Date().addingTimeInterval(-86400 * 30),
                                     dateCompleted: Date().addingTimeInterval(-86400 * 20))
            
            let shelfItem2 = ShelfItem(id: UUID(),
                                     userId: userId,
                                     bookId: book2.id,
                                     status: .reading,
                                     rating: nil,
                                     notes: nil,
                                     highlights: [],
                                     dateAdded: Date().addingTimeInterval(-86400 * 5),
                                     dateCompleted: nil)
            
            self.shelfItems = [shelfItem1, shelfItem2]
            self.isLoading = false
        }
    }
    
    func addBook(_ book: Book, status: ShelfItem.ReadingStatus) {
        let newItem = ShelfItem(id: UUID(),
                              userId: UUID(), // In real app, get current user
                              bookId: book.id,
                              status: status,
                              rating: nil,
                              notes: nil,
                              highlights: [],
                              dateAdded: Date(),
                              dateCompleted: nil)
        shelfItems.append(newItem)
    }
    
    func updateShelfItem(_ item: ShelfItem) {
        if let index = shelfItems.firstIndex(where: { $0.id == item.id }) {
            shelfItems[index] = item
        }
    }
}
