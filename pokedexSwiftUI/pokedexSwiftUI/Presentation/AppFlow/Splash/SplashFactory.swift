//
//  SplashFactory.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 25/09/25.
//

import SwiftUI

protocol SplashFactory {
    func makeScene() -> AnyView
}

struct SplashFactoryLive: SplashFactory {
    let nav: Navigating

    func makeScene() -> AnyView {
        AnyView(
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                        nav.setRoot(.onboarding)
                    }
                }
        )
    }
}
