//
//  OnboardingViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 15/09/25.
//

import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var onboardingSteps: [InfoTextKeys] = [
        InfoTextKeys(titleKey: "Todos os Pokémons em um só Lugar", descriptionKey: "Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo"),
        InfoTextKeys(titleKey: "Mantenha sua\nPokédex atualizada", descriptionKey: "Cadastre-se e mantenha seu perfil, pokémon favoritos, configurações e muito mais, salvos no aplicativo, mesmo sem conexão com a internet.")
    ]
}
