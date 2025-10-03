//
//  SignedInUser.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 03/10/25.
//

protocol SignedInUser {
    var id: String { get }
    var email: String { get }
    var name: String { get }
}
