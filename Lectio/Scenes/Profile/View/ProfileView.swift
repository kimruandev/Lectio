//
//  ProfileView.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações do Perfil")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.user.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(viewModel.user.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Estatísticas")) {
                    HStack {
                        VStack {
                            Text("\(viewModel.user.totalPoints)")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Pontos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(viewModel.booksReadCount)")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Livros Lidos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        VStack {
                            Text("\(viewModel.currentStreak)")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Dia(s) de Streak")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(viewModel.user.badges.count)")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Conquistas")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Preferências de Leitura")) {
                    Picker("Perfil de Leitor", selection: $viewModel.selectedProfile) {
                        ForEach(User.ReaderProfile.allCases, id: \.self) { profile in
                            Text(profile.rawValue).tag(profile)
                        }
                    }
                    
                    Toggle(isOn: $viewModel.notificationsEnabled) {
                        Text("Receber Lembretes")
                    }
                }
                
                Section(header: Text("Conquistas")) {
                    if viewModel.user.badges.isEmpty {
                        Text("Nenhuma conquista ainda")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.user.badges) { badge in
                                    VStack {
                                        Image(systemName: badge.iconName)
                                            .font(.system(size: 30))
                                            .frame(width: 60, height: 60)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(12)
                                        
                                        Text(badge.name)
                                            .font(.caption)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(width: 80)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Meu Perfil")
        }
    }
}

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
