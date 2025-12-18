//
//  LoginViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 02/11/25.
//
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
}
