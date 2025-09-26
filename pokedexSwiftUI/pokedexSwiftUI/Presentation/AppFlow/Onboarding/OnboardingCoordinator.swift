//
//  OnboardingCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 24/09/25.
//

import Foundation

final class OnboardingCoordinator: OnboardingCoordinating {
    private let nav: Navigating
    init(nav: Navigating) { self.nav = nav }
    func goToLoginOrRegister() {
        //nav.setRoot(.loginOrRegister)
    }
}
