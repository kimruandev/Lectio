//
//  BookCard.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

struct BookCard: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Book cover
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 180)
                .overlay(
                    VStack {
                        Text(book.title)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], 8)

                        Text("por \(book.author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Label("\(book.pageCount) páginas", systemImage: "book.fill")
                    Spacer()
                    Label("\(book.genres.joined(separator: ", "))", systemImage: "tag.fill")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
