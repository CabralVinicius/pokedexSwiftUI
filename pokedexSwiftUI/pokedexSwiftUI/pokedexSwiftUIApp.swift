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
            // Factories concretas
            let splash = SplashFactoryLive(nav: nav)
            let onboarding = OnboardingFactoryLive(nav: nav)

            let router = AppRouter(
                splashFactory: splash,
                onboardingFactory: onboarding
            )

            NavigationStack(path: $nav.path) {
                RootHostView(router: router)
                    .environmentObject(nav)
                    .navigationDestination(for: AppRoute.self) { route in
                        router.view(for: route)
                    }
                    .sheet(item: $nav.sheet) { route in
                        router.view(for: route)
                    }
                    .fullScreenCover(item: $nav.cover) { route in
                        router.view(for: route)
                    }
            }
        }
    }
}
