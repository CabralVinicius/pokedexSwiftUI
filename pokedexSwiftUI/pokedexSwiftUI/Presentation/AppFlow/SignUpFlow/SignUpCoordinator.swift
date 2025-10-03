//
//  SignUpCoordinator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

import SwiftUI
import Combine

final class SignUpCoordinator: SignUpCoordinatoring, ObservableObject {
    private let nav: AppNavigator
    
    init(nav: AppNavigator) { self.nav = nav }
    
    func back() { withAnimation { nav.pop() } }
    
    func finishedSignUp(user: some SignedInUser) {
        // Ex.: empurra próxima rota, ou troca root
        print("✅✅✅ FEZ O CADASTRO ✅✅✅")
        withAnimation { nav.popToRoot() }
    }
    deinit{
        print("🚫🚫 RegisterCoordinator DESTRUIDO  🚫🚫")
    }
}
