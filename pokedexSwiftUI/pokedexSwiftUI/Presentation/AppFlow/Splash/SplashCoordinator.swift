//
//  SplashCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI
import Combine

final class SplashCoordinator: ObservableObject {
    private let nav: AppNavigator
    
    init(nav: AppNavigator) {
        self.nav = nav
    }
    
    func start() {
        withAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                self.nav.setRoot(.onboarding)
            }
        }
    }
}
