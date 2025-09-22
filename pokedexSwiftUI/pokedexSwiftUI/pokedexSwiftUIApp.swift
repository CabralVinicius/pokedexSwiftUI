//
//  pokedexSwiftUIApp.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 13/09/25.
//

import SwiftUI

@main
struct pokedexSwiftUIApp: App {
    @StateObject private var nav = AppNavigator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $nav.path) {
                RootHostView()
                    .navigationDestination(for: AppRoute.self) { route in
                        nav.destination(route)
                    }
                    .sheet(item: $nav.sheet) { route in
                        nav.destination(route)
                    }
                    .fullScreenCover(item: $nav.cover) { route in
                        nav.destination(route)
                    }
            }
            .environmentObject(nav)
        }
    }
}
