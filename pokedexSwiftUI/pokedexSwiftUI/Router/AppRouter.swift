//
//  AppRouter.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI
import Foundation

enum AppRoute: Hashable, Identifiable {
    case splash
    case onboarding
    //case loginOrRegister   

    var id: String { String(describing: self) }
}


struct AppRouter {
    let splashFactory: SplashFactory
    let onboardingFactory: OnboardingFactory
    // no futuro: let authFactory: AuthFactory, etc.

    @ViewBuilder
    func view(for route: AppRoute) -> some View {
        switch route {
        case .splash:
            splashFactory.makeScene()
        case .onboarding:
            onboardingFactory.makeScene()
//        case .loginOrRegister:
//            // placeholder simples para não quebrar compilação
//            AnyView(LoginOrRegisterScene())
        }
    }
}
