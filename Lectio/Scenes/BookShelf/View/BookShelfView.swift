//
//  BookShelfView.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI
import Combine

struct BookShelfView: View {
    @StateObject private var viewModel = BookShelfViewModel()
    @State private var showingAddBook = false

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.shelfItems.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.shelfItems) { item in
                            NavigationLink(destination: BookDetailView(shelfItem: item)) {
                                ShelfItemRow(item: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle(String(localized: "NavBar.MyShelf"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddBook = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView { book, status in
                    viewModel.addBook(book, status: status)
                }
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        viewModel.shelfItems.remove(atOffsets: offsets)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "books.vertical")
                .font(.system(size: 50))
                .foregroundColor(.secondary)

            Text(String(localized: "EmptyState.ShelfEmpty"))
                .font(.title2)
                .fontWeight(.semibold)

            Text(String(localized: "EmptyState.ShelfEmptyDescription"))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct ShelfItemRow: View {
    let item: ShelfItem

    var body: some View {
        HStack(spacing: 12) {
            // Book cover placeholder
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 60, height: 80)
                .cornerRadius(8)
                .overlay(
                    Text(item.status == .reading ? String(localized: "BookStatus.Reading") :
                         item.status == .wantToRead ? String(localized: "BookStatus.WantToRead") : String(localized: "BookStatus.Read"))
                        .font(.caption)
                        .fontWeight(.bold)
                        .rotationEffect(.degrees(-90))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(item.bookTitle) // We'll need to get this from book - for now placeholder
                    .font(.headline)
                    .lineLimit(1)

                Text(item.bookAuthor) // Placeholder
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Progress indicator
                if item.status == .reading {
                    ProgressView(value: 0.5) // Placeholder progress
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(height: 4)
                }

                HStack {
                    Spacer()
                    if let rating = item.rating {
                        HStack(spacing: 2) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct BookshelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfView()
    }
}