//
//  OnboardingCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 24/09/25.
//

import SwiftUI
import Combine

final class OnboardingCoordinator: ObservableObject {
    private let nav: AppNavigator
    
    init(nav: AppNavigator) {
        self.nav = nav
    }
    
    func start() {
        withAnimation {
                self.nav.push(.loginOrRegister)
        }
    }
    
    deinit{
        print("🚫🚫 OnboardingCoordinator DESTRUIDO  🚫🚫")
    }
}
