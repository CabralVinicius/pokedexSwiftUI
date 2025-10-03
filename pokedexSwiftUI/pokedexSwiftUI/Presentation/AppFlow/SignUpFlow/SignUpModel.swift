//
//  SignUpModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

struct SignUpModel: SignedInUser, Equatable {
    var id: String
    var name: String
    var email: String
    var password: String
}
