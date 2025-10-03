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
        case .email:    return "signup.titleTop.start"
        case .password: return "signup.titleTop.now"
        case .name:     return "signup.titleTop.finish"
        }
    }
    
    var titleMain: String {
        switch self {
        case .email:    return "signup.titleMain.email"
        case .password: return "signup.titleMain.password"
        case .name:     return "signup.titleMain.name"
        }
    }
    
    var helperText: String {
        switch self {
        case .email:    return "signup.helper.email"
        case .password: return "signup.helper.password"
        case .name:     return "signup.helper.name"
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:    return "signup.placeholder.email"
        case .password: return "signup.placeholder.password"
        case .name:     return "signup.placeholder.name"
        }
    }
    
    var buttonTitle: String { self == .name ? "auth.createAccount" : "common.continue" }
}

// MARK: - ViewModel
@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var step: SignUpStep = .email
    @Published var showPassword: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let service: SignUpServicing

    init(service: SignUpServicing = SignUpService()) {
        self.service = service
    }

    var isContinueEnabled: Bool {
        switch step {
        case .email:
            return isValidEmail(email)
        case .password:
            return password.count >= 8
        case .name:
            return name.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2
        }
    }

    func makeRequest() -> SignUpRequest {
        .init(email: email, password: password, name: name)
    }

    func nextStep() {
        guard let next = SignUpStep(rawValue: step.rawValue + 1) else { return }
        withAnimation(.easeInOut) { step = next }
    }

    func previousStep() {
        guard let prev = SignUpStep(rawValue: step.rawValue - 1) else { return }
        withAnimation(.easeInOut) { step = prev }
    }

    func submit() async -> User? {
        guard isContinueEnabled else { return nil }
        isLoading = true
        defer { isLoading = false }

        do {
            let dto = makeRequest()
            let user = try await service.register(dto)
            return user
        } catch {
            errorMessage = mapError(error)
            return nil
        }
    }

    // MARK: - Helpers
    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"(?i)^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return email.range(of: regex, options: [.regularExpression]) != nil
    }

    private func mapError(_ error: Error) -> String {
        switch error {
        case SignUpError.invalidStatus(let code):
            return "Erro ao criar a conta (status \(code))."
        case SignUpError.decoding:
            return "Não consegui interpretar a resposta do servidor."
        case SignUpError.transport(let underlying):
            return "Falha de rede: \(underlying.localizedDescription)"
        default:
            return "Não foi possível criar a conta. Tente novamente."
        }
    }
}

// MARK: - Metodo fake
extension SignUpViewModel{
    func submitMockUser() -> User {
        let user = User(id: "1234", email: "1@1.com", name: "Zé Maria")
        return user
    }
}
