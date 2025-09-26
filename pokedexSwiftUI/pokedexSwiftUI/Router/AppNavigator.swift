//
//  AppNavigator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import SwiftUI
import Combine

// Contrato para navegação (DIP)
protocol Navigating: AnyObject {
    func setRoot(_ route: AppRoute)
    func push(_ route: AppRoute)
    func pop()
    func popToRoot()
    func present(_ route: AppRoute)
    func fullCover(_ route: AppRoute)
}

@MainActor
final class AppNavigator: ObservableObject, Navigating {
    @Published var root: AppRoute = .splash
    @Published var path = NavigationPath()
    @Published var sheet: AppRoute?
    @Published var cover: AppRoute?

    func setRoot(_ route: AppRoute) {
        root = route
        path = NavigationPath()
        sheet = nil
        cover = nil
    }

    func push(_ route: AppRoute) { path.append(route) }
    func pop() { if !path.isEmpty { path.removeLast() } }
    func popToRoot() { path = NavigationPath() }

    func present(_ route: AppRoute) { sheet = route }
    func fullCover(_ route: AppRoute) { cover = route }
}
