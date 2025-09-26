//
//  OnboardingInteractor.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 25/09/25.
//

import Foundation

final class OnboardingInteractor: OnboardingBusinessLogic {
    private let service: OnboardingServicing
    private weak var presenter: OnboardingPresenting?

    init(service: OnboardingServicing, presenter: OnboardingPresenting) {
        self.service = service
        self.presenter = presenter
    }

    func handle(_ intent: OnboardingIntent) async {
        switch intent {
        case .onAppear, .retry:
            await presenter?.presentLoading()
            do {
                let steps = try await service.loadSteps()
                await presenter?.present(steps: steps, current: 0)
            } catch {
                await presenter?.present(error: "Falha ao carregar onboarding")
            }

        case .stepChanged(let idx):
            // só reflete o índice; passos atuais já foram carregados
            // Presenter ajusta o estado mantendo os steps
            await presenter?.present(steps: [], current: idx)

        case .continueTapped:
            // regra de negócio poderia validar algo aqui antes de navegar
            // navegação é disparada pelo Presenter (via Coordinator)
            await presenter?.presentLoading() // opcional (efeito)
            // quem navega: Presenter.primaryTapped -> coordinator.goToLoginOrRegister()
            // nada a fazer aqui

        }
    }
}
