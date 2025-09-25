//
//  OnboardingCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 24/09/25.
//

import SwiftUI
import Combine

protocol OnboardingCoordinatoring {
    func start()
}

final class OnboardingCoordinator: OnboardingCoordinatoring, ObservableObject {
    private let nav: AppNavigator
    
    init(nav: AppNavigator) {
        self.nav = nav
    }
    
    func start() {
        withAnimation {
                self.nav.setRoot(.loginOrRegister)
        }
    }
}
