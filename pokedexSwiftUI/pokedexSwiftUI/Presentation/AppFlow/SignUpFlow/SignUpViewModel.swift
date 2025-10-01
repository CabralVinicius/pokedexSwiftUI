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
