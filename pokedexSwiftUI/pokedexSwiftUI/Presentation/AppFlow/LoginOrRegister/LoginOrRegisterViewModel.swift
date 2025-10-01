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
        titleKey: "auth.welcome.title",
        descriptionKey: "auth.welcome.description"
    )
}
