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
    func startRegister()
    func startLogin()
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
    
    func startLogin() {
        self.nav.push(.makeLogin)
    }
    
    deinit{
        print("🚫🚫 RegisterCoordinator DESTRUIDO  🚫🚫")
    }
}
