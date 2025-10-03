//
//  SignUpRequest.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 03/10/25.
//

// Transporte (o que vai no corpo da requisição)
struct SignUpRequest: Encodable {
    let email: String
    let password: String
    let name: String
}
