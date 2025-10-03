//
//  RegisterViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 23/09/25.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var loginOrRegisterInformations: [InfoTextKeys] = [
    InfoTextKeys(
        titleKey: "auth.register.title",
        descriptionKey: "auth.connect.how"),
    InfoTextKeys(
        titleKey: "auth.login.title",
        descriptionKey: "auth.connect.how")
    ]
    
    func teste(){
        print("teste")
    }
}
