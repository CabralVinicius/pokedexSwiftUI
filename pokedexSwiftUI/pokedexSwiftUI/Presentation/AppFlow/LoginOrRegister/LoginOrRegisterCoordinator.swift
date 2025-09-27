//
//  LoginOrRegisterCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 24/09/25.
//

import SwiftUI
import Combine

final class LoginOrRegisterCoordinator: ObservableObject {
    private let nav: AppNavigator
    
    init(nav: AppNavigator) {
        self.nav = nav
    }
    
    func register() {
        withAnimation {
                self.nav.push(.register)
        }
    }
    
    func login() {
        withAnimation {
            self.nav.push(.login)
        }
    }
    
    func back(){
        withAnimation {
            self.nav.pop()
        }
    }
    
    deinit{
        print("🚫🚫 LoginOrRegisterCoordinator DESTRUIDO  🚫🚫")
    }
}
