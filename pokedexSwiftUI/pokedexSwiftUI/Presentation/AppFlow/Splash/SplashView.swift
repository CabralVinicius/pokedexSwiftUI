//
//  SplashView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 17/09/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var nav: AppNavigator
    
    var body: some View {
        ZStack{
            Color(ColorsNames.backgroundBlue)
            Image(ImageKey.logoSplash.rawValue)
                .resizable()
                .frame(width: 192, height: 71)
        }
        .ignoresSafeArea()
        .onAppear {
            SplashCoordinator(nav: nav).start()
        }
    }
}

#Preview {
    SplashView().environmentObject(AppNavigator())
}
