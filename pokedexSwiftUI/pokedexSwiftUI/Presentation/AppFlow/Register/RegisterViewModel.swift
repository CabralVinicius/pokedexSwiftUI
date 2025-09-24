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
        titleKey: "Falta pouco para\nexplorar esse mundo!",
        descriptionKey: "Como deseja se conectar?"),
    InfoTextKeys(
        titleKey: "Que bom te ver aqui novamente!",
        descriptionKey: "Como deseja se conectar?")
    ]
    
    func teste(){
        print("teste")
    }
}
