//
//  RootHostView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI

struct RootHostView: View {
    @EnvironmentObject var nav: AppNavigator
    private let router = AppRouter()

    var body: some View {
        ZStack {
            router.view(for: nav.root)
                .id(nav.root)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal:   .move(edge: .leading).combined(with: .opacity)
                ))
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.9), value: nav.root)
    }
}
