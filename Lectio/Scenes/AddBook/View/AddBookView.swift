//
//  AddBookView.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import Combine
import SwiftUI

struct AddBookView: View {
    let onAdd: (Book, ShelfItem.ReadingStatus) -> Void
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddBookViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(String(localized: "SectionHeader.AddBook"))) {
                    TextField(String(localized: "Placeholder.BookTitle"), text: $viewModel.title)
                    TextField(String(localized: "Placeholder.Author"), text: $viewModel.author)

                    Stepper(value: $viewModel.pageCount, in: 1...5000) {
                        Text("\(viewModel.pageCount) \(String(localized: "Stepper.Pages"))")
                    }

                    Stepper(value: $viewModel.chapterCount, in: 0...1000) {
                        Text(viewModel.chapterCount == 0 ?
                            String(localized: "Stepper.ChaptersNone") :
                            "\(viewModel.chapterCount) \(String(localized: "Stepper.Pages"))")
                    }

                    TextField(String(localized: "Placeholder.Genres"), text: $viewModel.genres)
                        .placeholder(when: viewModel.genres.isEmpty) {
                            Text(String(localized: "Placeholder.GenresExample")).foregroundColor(.gray)
                        }

                    TextEditor(text: $viewModel.synopsis)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                }

                Section(header: Text(String(localized: "SectionHeader.InitialStatus"))) {
                    Picker(String(localized: "Label.Status"), selection: $viewModel.initialStatus) {
                        ForEach(ShelfItem.ReadingStatus.allCases, id: \.self) { status in
                            Text(statusText(status)).tag(status)
                        }
                    }
                }
            }
            .navigationTitle(String(localized: "NavBar.AddBook"))
            .navigationBarItems(
                leading: Button(String(localized: "Button.Cancel")) {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button(String(localized: "Button.Add")) {
                    let book = Book(id: UUID(),
                                  title: viewModel.title,
                                  author: viewModel.author,
                                  pageCount: viewModel.pageCount,
                                  chapterCount: viewModel.chapterCount == 0 ? nil : viewModel.chapterCount,
                                  genres: viewModel.genres.isEmpty ? [] : viewModel.genres.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) },
                                  synopsis: viewModel.synopsis,
                                  coverURL: nil)

                    onAdd(book, viewModel.initialStatus)
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .disabled(!viewModel.isValid)
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

// MARK: - Preview
struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView { book, status in
            // Preview doesn't actually add the book
        }
    }
}