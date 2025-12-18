//
//  LoginOrRegisterView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI
//tela de registro ou cadastro
struct LoginOrRegisterView: View {
    @ObservedObject var viewModel: LoginOrRegisterViewModel
    @EnvironmentObject var nav: AppNavigator
    private let defaultPadding: CGFloat = 16
    private let fontSize: CGFloat = 18
    private let imageSize: CGFloat = 27
    
    var body: some View {
        VStack{
            Spacer().frame(height: 120)
            MakeTrainingImage(firstImage: ImageKey.femaleCoachTwo.rawValue, secondImage: ImageKey.maleCoachThree.rawValue)
            TitleDescriptionView(title: viewModel.loginOrRegisterInformations.titleKey, description: viewModel.loginOrRegisterInformations.descriptionKey)
            Spacer().frame(height: 35)
            registerNewAccount
            Spacer().frame(height: defaultPadding)
            loginAccount
        }
        .navToolbar(leadingTitle: String(localized: "common.back")) {
            LoginOrRegisterCoordinator(nav: nav).back()
        }
    }

    private var registerNewAccount: some View {
        Button(action: {
            LoginOrRegisterCoordinator(nav: nav).register()
        }, label: {
            Rectangle()
                .frame(height: 58)
                .clipShape(.capsule)
                .foregroundStyle(ColorsNames.darkBlue)
                .overlay {
                    Text(LocalizedStringKey("auth.createAccount"))
                        .foregroundStyle(.white)
                        .font(FontMaker.makeFont(.poppinsSemiBold, fontSize))
                }
                .padding(.horizontal, defaultPadding)
                .padding(.bottom, defaultPadding)
        })
    }
    
    private var loginAccount: some View {
        Button(action: {
            LoginOrRegisterCoordinator(nav: nav).login()
        }, label: {
            Text(LocalizedStringKey("auth.alreadyHaveAccount"))
                .foregroundStyle(ColorsNames.darkBlue)
                .font(FontMaker.makeFont(.poppinsSemiBold, fontSize))
        })
        .padding(.horizontal, defaultPadding)
        .padding(.bottom, defaultPadding)
    }
}

#Preview {
    LoginOrRegisterView(viewModel: LoginOrRegisterViewModel())
}
