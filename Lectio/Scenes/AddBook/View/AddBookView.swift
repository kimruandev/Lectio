//
//  AddBookView.swift
//  Lectio
//
import Combine
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

struct AddBookView: View {
    let onAdd: (Book, ShelfItem.ReadingStatus) -> Void
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddBookViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Adicionar Livro")) {
                    TextField("Título do Livro", text: $viewModel.title)
                    TextField("Autor", text: $viewModel.author)
                    
                    Stepper(value: $viewModel.pageCount, in: 1...5000) {
                        Text("\(viewModel.pageCount) páginas")
                    }
                    
                    Stepper(value: $viewModel.chapterCount, in: 0...1000) {
                        Text(viewModel.chapterCount == 0 ? "Capítulos: Não informado" : "\(viewModel.chapterCount) capítulos")
                    }
                    
                    TextField("Gêneros (separados por vírgula)", text: $viewModel.genres)
                        .placeholder(when: viewModel.genres.isEmpty) {
                            Text("Ex: Fantasia, Romance, Ficção Científica").foregroundColor(.gray)
                        }
                    
                    TextEditor(text: $viewModel.synopsis)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                }
                
                Section(header: Text("Status Inicial")) {
                    Picker("Status", selection: $viewModel.initialStatus) {
                        ForEach(ShelfItem.ReadingStatus.allCases, id: \.self) { status in
                            Text(statusText(status)).tag(status)
                        }
                    }
                }
            }
            .navigationTitle("Adicionar Livro")
            .navigationBarItems(
                leading: Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Adicionar") {
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
                .disabled(!viewModel.isValid)
            )
        }
    }
    
    private func statusText(_ status: ShelfItem.ReadingStatus) -> String {
        switch status {
        case .wantToRead: return "Quero Ler"
        case .reading: return "Lendo"
        case .read: return "Lido"
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
