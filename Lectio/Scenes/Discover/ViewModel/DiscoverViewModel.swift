//
//  DiscoverViewModel.swift
//  Lectio
//
import Combine
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

class DiscoverViewModel: ObservableObject {
    @Published var recommendedBooks: [Book] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var searchResults: [Book] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadMockData()
        setupSearch()
    }

    func loadMockData() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Mock data - in real app, this would come from API
            let books = [
                Book(id: UUID(),
                     title: "O Senhor dos Anéis",
                     author: "J.R.R. Tolkien",
                     pageCount: 1178,
                     chapterCount: 62,
                     genres: ["Fantasia", "Aventura"],
                     synopsis: "Em uma terra chamada Terra-Média, o hobbit Frodo Bolseiro herda um anel mágico de seu primo Bilbo.",
                     coverURL: nil),
                Book(id: UUID(),
                     title: "Fundação",
                     author: "Isaac Asimov",
                     pageCount: 256,
                     chapterCount: 30,
                     genres: ["Ficção Científica"],
                     synopsis: "Hari Seldon desenvolve a psicohistoria, uma ciência matemática que pode prever o futuro de grandes populações.",
                     coverURL: nil),
                Book(id: UUID(),
                     title: "Orgulho e Preconceito",
                     author: "Jane Austen",
                     pageCount: 432,
                     chapterCount: 61,
                     genres: ["Romance", "Clássico"],
                     synopsis: "A história acompanha a vida das cinco irmãs Bennet, especialmente Elizabeth, enquanto navegam por questões de casamento, moralidade e equívocos.",
                     coverURL: nil)
            ]

            self.recommendedBooks = books
            self.isLoading = false
        }
    }

    func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { text in
                if text.isEmpty {
                    return []
                } else {
                    // In real app, filter from a larger dataset
                    return self.recommendedBooks.filter { $0.title.localizedCaseInsensitiveContains(text) }
                }
            }
            .assign(to: &$searchResults)
    }
}
