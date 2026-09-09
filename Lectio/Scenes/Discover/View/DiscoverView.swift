//
//  DiscoverView.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI
import Combine

struct DiscoverView: View {
    @StateObject private var viewModel = DiscoverViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach(viewModel.recommendedBooks) { book in
                            NavigationLink(destination: BookDetailView(
                                shelfItem: ShelfItem(
                                    id: UUID(),
                                    userId: UUID(),
                                    bookId: book.id,
                                    status: .wantToRead,
                                    rating: nil,
                                    notes: nil,
                                    highlights: [],
                                    dateAdded: Date(),
                                    dateCompleted: nil
                                )
                            )) {
                                BookCard(book: book)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Descobrir")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { /* Refresh */ }) {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always)) {
                        ForEach(viewModel.searchResults) { book in
                            Text(book.title)
                                .searchCompletion(book.title)
                        }
                    }
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
