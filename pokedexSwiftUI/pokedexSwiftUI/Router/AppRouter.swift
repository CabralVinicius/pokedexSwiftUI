//
//  AppRouter.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI

enum AppRoute: Hashable, Identifiable{
    case splash
    case onboarding
    case authLanding
    case register
    case login
    //case home
    //case pokemonDetail(id: Int)
    
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
        case .authLanding:
            LoginOrRegisterView(viewModel: LoginOrRegisterViewModel())
        case .register:
            RegisterView()
        case .login:
            LoginAccountView()
        //case .home:
            //HomeView() // crie depois
        //case .pokemonDetail(let id):
            //PokemonDetailView(id: id)
        }
    }
}
