//
//  OnboardingFactory.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 25/09/25.
//

import SwiftUI

protocol OnboardingFactory {
    func makeScene() -> AnyView
}

struct OnboardingFactoryLive: OnboardingFactory {
    let nav: Navigating

    func makeScene() -> AnyView {
        let coordinator = OnboardingCoordinator(nav: nav)
        let presenter = OnboardingPresenter(coordinator: coordinator)
        let service = OnboardingService()
        let interactor = OnboardingInteractor(service: service, presenter: presenter)
        presenter.interactor = interactor
        return AnyView(OnboardingView(presenter: presenter))
    }
}
