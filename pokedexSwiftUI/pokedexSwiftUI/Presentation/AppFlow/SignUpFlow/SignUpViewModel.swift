//
//  SignUpViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

import SwiftUI
import Combine
import Foundation

enum SignUpStep: Int, CaseIterable {
    case email, password, name
    
    var titleTop: String {
        switch self {
        case .email:    return "Vamos começar!"
        case .password: return "Agora..."
        case .name:     return "Pra finalizar"
        }
    }
    
    var titleMain: String {
        switch self {
        case .email:    return "Qual é o seu e-mail?"
        case .password: return "Crie uma senha"
        case .name:     return "Qual é o seu nome?"
        }
    }
    
    var helperText: String {
        switch self {
        case .email:    return "Use um endereço de e-mail válido."
        case .password: return "Sua senha deve ter pelo menos 8 caracteres."
        case .name:     return "Esse será seu nome de usuário no aplicativo."
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:    return "E-mail"
        case .password: return "Senha"
        case .name:     return "Nome"
        }
    }
    
    var buttonTitle: String { self == .name ? "Criar conta" : "Continuar" }
}

// MARK: - ViewModel
@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var user: SignUpModel = SignUpModel(name: "", email: "", password: "")
    @Published var step: SignUpStep = .email
    @Published var showPassword: Bool = false
    @EnvironmentObject var nav: AppNavigator
    
    var isContinueEnabled: Bool {
        switch step {
        case .email:
            return isValidEmail(user.email)
        case .password:
            return user.password.count >= 8
        case .name:
            return user.name.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2
        }
    }
    
    func nextStep() {
        guard let next = SignUpStep(rawValue: step.rawValue + 1) else { return }
        withAnimation(.easeInOut) { step = next }
    }
    
    func previousStep() {
        guard let prev = SignUpStep(rawValue: step.rawValue - 1) else { return }
        withAnimation(.easeInOut) { step = prev }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"(?i)^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return email.range(of: regex, options: [.regularExpression]) != nil
    }
}
