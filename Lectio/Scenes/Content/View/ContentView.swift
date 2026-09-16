//
//  ContentView.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BookShelfView()
                .tabItem {
                    Label(String(localized: "TabBar.Shelf"), systemImage: "books.vertical")
                }

            DiscoverView()
                .tabItem {
                    Label(String(localized: "TabBar.Discover"), systemImage: "magnifyingglass")
                }

            ProfileView()
                .tabItem {
                    Label(String(localized: "TabBar.Profile"), systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}