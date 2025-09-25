//
//  AppNavigator.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 22/09/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AppNavigator: ObservableObject {
    @Published var root: AppRoute = .splash
    @Published var path = NavigationPath()
    @Published var sheet: AppRoute?
    @Published var cover: AppRoute?

    private let router = AppRouter()

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

    @ViewBuilder
    func destination(_ route: AppRoute) -> some View {
        router.view(for: route)
    }
}
