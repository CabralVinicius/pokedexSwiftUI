//
//  RegisterCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 24/09/25.
//

import SwiftUI
import Combine

protocol RegisterCoordinatoring{
    func back()
}

final class RegisterCoordinator: RegisterCoordinatoring, ObservableObject {
    private let nav: AppNavigator
    
    init(nav: AppNavigator) {
        self.nav = nav
    }
    
    func back(){
        withAnimation {
            self.nav.pop()
        }
    }
    
    func startRegister(){
        self.nav.push(.signUp)
    }
    
    deinit{
        print("🚫🚫 RegisterCoordinator DESTRUIDO  🚫🚫")
    }
}
