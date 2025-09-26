//
//  OnboardingViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 15/09/25.
//

import Foundation
import Combine

@MainActor
final class OnboardingPresenter: ObservableObject {
    @Published private(set) var state = OnboardingState()

    weak var interactor: OnboardingBusinessLogic?
    private let coordinator: OnboardingCoordinating

    init(coordinator: OnboardingCoordinating) {
        self.coordinator = coordinator
    }

    // Intents da View
    func send(_ intent: OnboardingIntent) { Task { await interactor?.handle(intent) } }
    func primaryTapped() { coordinator.goToLoginOrRegister() }
}

// MARK: - OnboardingPresenting (callbacks do interactor)
extension OnboardingPresenter: OnboardingPresenting {
    func presentLoading() {
        state.isLoading = true
        state.error = nil
    }

    func present(steps: [InfoTextKeys], current: Int) {
        state.isLoading = false
        state.error = nil
        if !steps.isEmpty { state.steps = steps }
        state.currentStep = max(0, min(current, max(state.steps.count - 1, 0)))
    }

    func present(error: String) {
        state.isLoading = false
        state.error = error
    }
}
