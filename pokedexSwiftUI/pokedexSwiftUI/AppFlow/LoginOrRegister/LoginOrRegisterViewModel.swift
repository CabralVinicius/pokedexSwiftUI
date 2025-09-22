//
//  LoginOrRegisterViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import Foundation
import SwiftUI
import Combine

class LoginOrRegisterViewModel: ObservableObject {
    @Published var loginOrRegisterInformations: OnboardingStepModel =
    OnboardingStepModel(
        title: "Está pronto para essa aventura?",
        description: "Basta criar uma conta e começar a explorar o mundo dos Pokémon hoje!"
    )
}
