//
//  SplashCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI
import Combine

final class SplashCoordinator: ObservableObject {
    var nav: AppNavigator?
    
    init() {
        // Coordinator será inicializado sem navigator e receberá via propriedade
    }
    
    func start() {
        guard let nav = nav else { return }
        withAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                nav.setRoot(.onboarding)
            }
        }
    }
    
    deinit{
        print("🚫🚫 SplashCoordinator DESTRUIDO  🚫🚫")
    }
}
