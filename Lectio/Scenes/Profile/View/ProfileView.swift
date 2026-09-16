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
            profileForm
        }
        .navigationTitle(String(localized: "NavBar.Profile"))
    }

    var profileForm: some View {
        Form {
            profileInfo

            profileStatistics

            profilePreferences

            profileAchievements
        }
    }

    var profileInfo: some View {
        Section(header: Text(String(localized: "SectionHeader.ProfileInfo"))) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.secondary)

                VStack(alignment: .leading) {
                    Text(viewModel.user?.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(viewModel.user?.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    var profileStatistics: some View {
        Section(header: Text(String(localized: "SectionHeader.Statistics"))) {
            HStack {
                VStack {
                    Text("\(viewModel.user?.totalPoints ?? 0)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(String(localized: "Label.Points"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack {
                    Text("\(viewModel.booksReadCount)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(String(localized: "Label.BooksRead"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            HStack {
                VStack {
                    Text("\(viewModel.currentStreak)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(String(localized: "Label.StreakDays"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack {
                    Text("\(viewModel.user?.badges.count ?? 0)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(String(localized: "Label.NoAchievements")) // Reusing for "Conquistas" label
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    var profilePreferences: some View {
        Section(header: Text(String(localized: "SectionHeader.ReadingPreferences"))) {
            Picker(String(localized: "Label.ReaderProfile"), selection: $viewModel.selectedProfile) {
                ForEach(User.ReaderProfile.allCases, id: \.self) { profile in
                    Text(readerProfileString(profile)).tag(profile)
                }
            }

            Toggle(isOn: $viewModel.notificationsEnabled) {
                Text(String(localized: "Label.Notifications"))
            }
        }
    }

    var profileAchievements: some View {
        Section(header: Text(String(localized: "SectionHeader.Achievements"))) {
            if viewModel.user?.badges.isEmpty ?? true {
                Text(String(localized: "Label.NoAchievements"))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.user?.badges ?? []) { badge in
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

    private func readerProfileString(_ profile: User.ReaderProfile) -> String {
        switch profile {
        case .fantasy: return String(localized: "ReaderProfile.Fantasy")
        case .romance: return String(localized: "ReaderProfile.Romance")
        case .sciFi: return String(localized: "ReaderProfile.SciFi")
        case .general: return String(localized: "ReaderProfile.General")
        }
    }
}

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}