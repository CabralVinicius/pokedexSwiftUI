//
//  OnboardingViewModel.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 15/09/25.
//

import Foundation
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var onboardingSteps: [InfoTextKeys]

    init(steps: [InfoTextKeys] = [
        InfoTextKeys(titleKey: "onboarding.step1.title", descriptionKey: "onboarding.step1.description"),
        InfoTextKeys(titleKey: "onboarding.step2.title", descriptionKey: "onboarding.step2.description")
    ]) {
        self.onboardingSteps = steps
    }
}
