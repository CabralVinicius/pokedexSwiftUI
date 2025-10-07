//
//  RegisterViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 23/09/25.
//

import Foundation
import Combine

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var currentSteps = 0
    @Published var loginOrRegisterInformations: [InfoTextKeys]
    
    init(steps: [InfoTextKeys] = [
        InfoTextKeys(
            titleKey: "auth.register.title", descriptionKey: "auth.connect.how"),
        InfoTextKeys(
            titleKey: "auth.login.title", descriptionKey: "auth.connect.how")
    ]) {
        self.loginOrRegisterInformations = steps
    }
    
    func teste(){
        print("teste")
    }
}
