//
//  OnboardingViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 15/09/25.
//

import Foundation
import SwiftUI
internal import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var onboardingSteps: [OnboardingStepModel] = [
        OnboardingStepModel(title: "Todos os Pokémons em um só Lugar", description: "Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo"),
        OnboardingStepModel(title: "Mantenha sua\nPokédex atualizada", description: "Cadastre-se e mantenha seu perfil, pokémon favoritos, configurações e muito mais, salvos no aplicativo, mesmo sem conexão com a internet.")
    ]
}
