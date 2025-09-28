//
//  SignUpViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

import Combine

class SignUpViewModel: ObservableObject{
    @Published var user: SignUpModel
    @Published var focusTextView: Bool
    
    init(user: SignUpModel) {
        self.user = user
        self.focusTextView = false
    }
}
