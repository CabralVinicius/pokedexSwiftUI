//
//  User.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 03/10/25.
//

// Domínio (o app usa depois do cadastro)
struct User: SignedInUser, Decodable, Equatable {
    let id: String
    let email: String
    let name: String
}
