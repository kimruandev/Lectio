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
                    Label("Estante", systemImage: "books.vertical")
                }
            
            DiscoverView()
                .tabItem {
                    Label("Descobrir", systemImage: "magnifyingglass")
                }
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
