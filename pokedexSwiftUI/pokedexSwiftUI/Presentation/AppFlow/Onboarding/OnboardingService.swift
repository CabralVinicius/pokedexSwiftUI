//
//  OnboardingService.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 25/09/25.
//

import Foundation

struct OnboardingService: OnboardingServicing {
    func loadSteps() async throws -> [InfoTextKeys] {
        // usa os mesmos textos do seu ViewModel antigo
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2s
        return [
            InfoTextKeys(titleKey: "Todos os Pokémons em um só Lugar",
                         descriptionKey: "Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo"),
            InfoTextKeys(titleKey: "Mantenha sua\nPokédex atualizada",
                         descriptionKey: "Cadastre-se e mantenha seu perfil, pokémon favoritos, configurações e muito mais, salvos no aplicativo, mesmo sem conexão com a internet.")
        ]
    }
}
