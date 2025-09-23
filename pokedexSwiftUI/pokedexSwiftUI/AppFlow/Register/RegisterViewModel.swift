//
//  RegisterViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 23/09/25.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    @Published var loginOrRegisterInformations: TextAndDescriptionModel =
    TextAndDescriptionModel(
        title: "Falta pouco para\nexplorar esse mundo!",
        description: "Como deseja se conectar?"
    )
    
    func teste(){
        print("teste")
    }
}
