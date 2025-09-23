//
//  LoginOrRegisterViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import Foundation
import Combine

class LoginOrRegisterViewModel: ObservableObject {
    @Published var loginOrRegisterInformations: InfoTextKeys =
    InfoTextKeys(
        titleKey: "Está pronto para essa aventura?",
        descriptionKey: "Basta criar uma conta e começar a explorar o mundo dos Pokémon hoje!"
    )
}
