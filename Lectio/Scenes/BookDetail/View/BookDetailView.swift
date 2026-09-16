//
//  BookDetailView.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

struct BookDetailView: View {
    let shelfItem: ShelfItem
    @State private var showingEditSheet = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Book cover
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .overlay(
                        VStack {
                            Text(shelfItem.bookTitle)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()

                            Text("por \(shelfItem.bookAuthor)")
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    )

                // Status and controls
                VStack(alignment: .leading, spacing: 16) {
                    StatusBadge(status: shelfItem.status)

                    HStack {
                        Button(action: { /* Update status */ }) {
                            Label(String(localized: "Button.UpdateProgress"), systemImage: "book.fill")
                        }
                        .buttonStyle(.borderedProminent)

                        Button(action: { showingEditSheet = true }) {
                            Label(String(localized: "Button.Edit"), systemImage: "pencil")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()

                // Details
                VStack(alignment: .leading, spacing: 12) {
                    DetailSection(title: String(localized: "SectionHeader.Details")) {
                        VStack(alignment: .leading, spacing: 8) {
                            DetailRow(label: String(localized: "Label.Pages"), value: "\(shelfItem.pageCount)")
                            DetailRow(label: String(localized: "Label.Chapters"), value: shelfItem.chapterCount != nil ? "\(shelfItem.chapterCount!)" : String(localized: "DetailView.ChaptersNone"))
                            DetailRow(label: String(localized: "Label.Genres"), value: shelfItem.genres.joined(separator: ", "))
                        }
                    }

                    if !shelfItem.synopsis.isEmpty {
                        DetailSection(title: String(localized: "SectionHeader.Synopsis")) {
                            Text(shelfItem.synopsis)
                                .foregroundColor(.secondary)
                        }
                    }

                    if let rating = shelfItem.rating, rating > 0 {
                        DetailSection(title: String(localized: "SectionHeader.Rating")) {
                            HStack {
                                ForEach(0..<5) { index in
                                    Image(systemName: index < rating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                    }
                                Spacer()
                            }
                        }
                    }

                    if let notes = shelfItem.notes, !notes.isEmpty {
                        DetailSection(title: String(localized: "SectionHeader.Notes")) {
                            Text(notes)
                                .foregroundColor(.secondary)
                        }
                    }

                    if let highlights = shelfItem.highlights, !highlights.isEmpty {
                        DetailSection(title: String(localized: "SectionHeader.Highlights")) {
                            ForEach(highlights) { highlight in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("“\(highlight.text)”")
                                        .italic()
                                        .foregroundColor(.primary)

                                    if let location = highlight.location {
                                        Text(location)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()

                Spacer()
            }
        }
        .navigationTitle(shelfItem.bookTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { /* Mark as read */ }) {
                    Image(systemName: shelfItem.status == .read ? "checkmark.circle.fill" : "checkmark.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditBookView(shelfItem: shelfItem) { updatedItem in
                // In real app, update the item
                // For now, just dismiss
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    // MARK: - Supporting Views

    struct StatusBadge: View {
        let status: ShelfItem.ReadingStatus

        var body: some View {
            HStack {
                Circle()
                    .fill(statusColor)
                    .frame(width: 12, height: 12)

                Text(statusText)
                    .font(.caption)
                    .fontWeight(.medium)

                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(statusColor.opacity(0.2))
            .cornerRadius(20)
        }

        private var statusText: String {
            switch status {
            case .wantToRead: return String(localized: "BookStatus.WantToRead")
            case .reading: return String(localized: "BookStatus.Reading")
            case .read: return String(localized: "BookStatus.Read")
            }
        }

        private var statusColor: Color {
            switch status {
            case .wantToRead: return .orange
            case .reading: return .blue
            case .read: return .green
            }
        }
    }

    struct DetailSection<Content: View>: View {
        let title: String
        let content: Content

        init(title: String, @ViewBuilder content: () -> Content) {
            self.title = title
            self.content = content()
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 4)

                content
            }
        }
    }

    struct DetailRow: View {
        let label: String
        let value: String

        var body: some View {
            HStack {
                Text(label)
                    .foregroundColor(.secondary)
                Spacer()
                Text(value)
                    .foregroundColor(.primary)
            }
        }
    }

    // Placeholder for edit view
    struct EditBookView: View {
        let shelfItem: ShelfItem
        let onSave: (ShelfItem) -> Void
        @Environment(\.presentationMode) var presentationMode

        var body: some View {
            NavigationView {
                Form {
                    Section(header: StatusBadge(status: shelfItem.status)) {
                        Picker(String(localized: "Label.Status"), selection: Binding(
                            get: { shelfItem.status },
                            set: { newValue in
                                // In real app, we'd update a copy
                            }
                        )) {
                            ForEach(ShelfItem.ReadingStatus.allCases, id: \.self) { status in
                                Text(statusText(status)).tag(status)
                            }
                        }
                    }

                    Section(header: Text(String(localized: "SectionHeader.Evaluation"))) {
                        Stepper(value: Binding(
                            get: { shelfItem.rating ?? 0 },
                            set: { newValue in
                                // Update rating
                            }
                        ), in: 0...5) {
                            if shelfItem.rating ?? 0 > 0 {
                                HStack {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < (shelfItem.rating ?? 0) ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    }
                                }
                            } else {
                                Text(String(localized: "EditBookView.NoRating"))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }

                    Section(header: Text(String(localized: "SectionHeader.Notes"))) {
                        TextEditor(text: Binding(
                            get: { shelfItem.notes ?? "" },
                            set: { _ in }
                        ))
                        .frame(height: 100)
                    }
                }
                .navigationTitle(String(localized: "NavBar.EditBook"))
                .navigationBarItems(
                    leading: Button(String(localized: "Button.Cancel")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    trailing: Button(String(localized: "Button.Save")) {
                        // In real app, we'd create an updated item and call onSave
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }

        private func statusText(_ status: ShelfItem.ReadingStatus) -> String {
            switch status {
            case .wantToRead: return String(localized: "BookStatus.WantToRead")
            case .reading: return String(localized: "BookStatus.Reading")
            case .read: return String(localized: "BookStatus.Read")
            }
        }
    }
}

// MARK: - Preview
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock shelf item for preview
        let mockBook = Book(
            id: UUID(),
            title: "O Hobbit",
            author: "J.R.R. Tolkien",
            pageCount: 310,
            chapterCount: 19,
            genres: ["Fantasia", "Aventura"],
            synopsis: "Bilbo Bolseiro é um hobbit que leva uma vida tranquila até que o mago Gandalf chega com um grupo de anões para recrutá-lo em uma aventura.",
            coverURL: nil
        )

        let mockShelfItem = ShelfItem(
            id: UUID(),
            userId: UUID(),
            bookId: mockBook.id,
            status: .reading,
            rating: 4,
            notes: "Maravilhosa aventura clássica!",
            highlights: [
                ShelfItem.Highlight(
                    id: UUID(),
                    text: "Em um buraco no chão vivia um hobbit.",
                    location: "Página 1",
                    dateCreated: Date()
                )
            ],
            dateAdded: Date().addingTimeInterval(-86400 * 10),
            dateCompleted: nil
        )

        return NavigationView {
            BookDetailView(shelfItem: mockShelfItem)
        }
    }
}