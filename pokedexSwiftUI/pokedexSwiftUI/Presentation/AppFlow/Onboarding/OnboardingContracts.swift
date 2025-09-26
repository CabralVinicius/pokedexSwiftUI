//
//  OnboardingContracts.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 25/09/25.
//

import Foundation

struct OnboardingState: Equatable {
    var currentStep: Int = 0
    var steps: [InfoTextKeys] = []
    var isLoading: Bool = false
    var error: String?
}

enum OnboardingIntent: Equatable {
    case onAppear
    case stepChanged(Int)
    case continueTapped
    case retry
}

protocol OnboardingBusinessLogic: AnyObject {
    func handle(_ intent: OnboardingIntent) async
}

protocol OnboardingPresenting: AnyObject {
    func presentLoading()
    func present(steps: [InfoTextKeys], current: Int)
    func present(error: String)
}

protocol OnboardingServicing {
    func loadSteps() async throws -> [InfoTextKeys]
}

protocol OnboardingCoordinating: AnyObject {
    func goToLoginOrRegister()
}
