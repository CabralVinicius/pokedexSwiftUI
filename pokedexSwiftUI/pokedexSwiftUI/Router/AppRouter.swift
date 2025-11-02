//
//  AppRouter.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI

enum AppRoute: Hashable, Identifiable {
    case splash
    case onboarding
    case loginOrRegister
    case register
    case login
    case signUp
    case makeLogin
    // case home
    // case pokemonDetail(id: Int)

    var id: String { String(describing: self) }
}

struct AppRouter {    
    @ViewBuilder
    func view(for route: AppRoute) -> some View {
        switch route {
        case .splash:
            SplashView()
        case .onboarding:
            OnboardingView(viewModel: OnboardingViewModel())
                //.navigationBarBackButtonHidden(true)
        case .loginOrRegister:
            LoginOrRegisterView(viewModel: LoginOrRegisterViewModel())
                .navigationBarBackButtonHidden(true)
        case .register:
            RegisterView(viewModel: RegisterViewModel(), register: false)
        case .login:
            RegisterView(viewModel: RegisterViewModel(), register: true)
        case .signUp:
            SignUpView(viewModel: SignUpViewModel())
        case .makeLogin:
            LoginView()
        }
    }
}
