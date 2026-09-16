//
//  String.swift
//  Lectio
//
//  Created by Kim Lopes on 09/16/26.
//

import Foundation

// MARK: - General App Strings
struct AppString {
    static let appName = "Lectio"
}

// MARK: - Tab Bar Strings
struct TabBarString {
    static let shelf = "Estante"
    static let discover = "Descobrir"
    static let profile = "Perfil"
}

// MARK: - Navigation Bar Strings
struct NavBarString {
    static let addBook = "Adicionar Livro"
    static let discover = "Descobrir"
    static let myShelf = "Minha Estante"
    static let profile = "Meu Perfil"
    static let editBook = "Editar Livro"
}

// MARK: - Button Strings
struct ButtonString {
    static let cancel = "Cancelar"
    static let add = "Adicionar"
    static let save = "Salvar"
    static let updateProgress = "Atualizar Progresso"
    static let edit = "Editar"
}

// MARK: - TextField and Input Placeholders
struct PlaceholderString {
    static let bookTitle = "Título do Livro"
    static let author = "Autor"
    static let genres = "Gêneros (separados por vírgula)"
    static let genresExample = "Ex: Fantasia, Romance, Ficção Científica"
    static let synopsis = "Sinopse"
}

// MARK: - Stepper Strings
struct StepperString {
    static let pages = "páginas"
    static let chapters = "Capítulos: "
    static let chaptersInfo = "Capítulos: %d"
    static let chaptersNone = "Capítulos: Não informado"
}

// MARK: - Section Header Strings
struct SectionHeaderString {
    static let addBook = "Adicionar Livro"
    static let initialStatus = "Status Inicial"
    static let readingPreferences = "Preferências de Leitura"
    static let statistics = "Estatísticas"
    static let achievements = "Conquistas"
    static let profileInfo = "Informações do Perfil"
    static let details = "Detalhes"
    static let synopsis = "Sinopse"
    static let rating = "Sua Avaliação"
    static let notes = "Notas"
    static let highlights = "Destaques"
    static let evaluation = "Avaliação"
}

// MARK: - Label Strings
struct LabelString {
    static let points = "Pontos"
    static let booksRead = "Livros Lidos"
    static let streakDays = "Dia(s) de Streak"
    static let pagesLabel = "Páginas"
    static let chaptersLabel = "Capítulos"
    static let genresLabel = "Gêneros"
    static let status = "Status"
    static let readerProfile = "Perfil de Leitor"
    static let notifications = "Receber Lembretes"
    static let noAchievements = "Nenhuma conquista ainda"
}

// MARK: - Empty State Strings
struct EmptyStateString {
    static let shelfEmpty = "Sua estante está vazia"
    static let shelfEmptyDescription = "Adicione livros para começar a acompanhar sua leitura"
}

// MARK: - Book Status Strings (from ShelfItem.ReadingStatus)
struct BookStatusString {
    static let wantToRead = "Quero Ler"
    static let reading = "Lendo"
    static let read = "Lido"
}

// MARK: - Reader Profile Strings (from User.ReaderProfile)
struct ReaderProfileString {
    static let fantasy = "Fantasia"
    static let romance = "Romance"
    static let sciFi = "Ficção Científica"
    static let general = "Geral"
}

// MARK: - DetailView Strings
struct DetailViewString {
    static let pagesInfo = "%d páginas"
    static let chaptersInfo = "%d capítulos"
    static let chaptersNone = "Não informado"
}

// MARK: - EditBookView Strings
struct EditBookViewString {
    static let noRating = "Sem avaliação"
}