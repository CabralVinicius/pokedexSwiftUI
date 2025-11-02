//
//  RegisterView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @EnvironmentObject var nav: AppNavigator
    var register: Bool
    private let defaultPadding: CGFloat = 16
    private let fontSize: CGFloat = 18
    private let imageSize: CGFloat = 27
    
    var body: some View {
        VStack{
            Spacer().frame(height: 60)
            MakeTrainingImage(
                firstImage:
                    register ?
                ImageKey.maleCoachFive.rawValue :
                    ImageKey.maleCoachFour.rawValue)
            TitleDescriptionView(title: register ? viewModel.loginOrRegisterInformations[0].titleKey : viewModel.loginOrRegisterInformations[1].titleKey, description: viewModel.loginOrRegisterInformations[0].descriptionKey)
            Spacer().frame(height: 45)
            createAccountWithApple
            createAccountWithGoogle
            createAccountWithEmailAndPassword
        }
        .navToolbar(centerTitle: register ? String(localized: "auth.register.titleBar") : String(localized: "auth.login.titleBar")){
            RegisterCoordinator(nav: nav).back()
        }
    }
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(), register: true)
        .environmentObject(AppNavigator())
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(), register: false)
        .environmentObject(AppNavigator())
}

extension RegisterView {
    private var createAccountWithApple: some View {
        CapsuleButton(
            title: String(localized: "auth.continueWithApple"),
            icon: .system("apple.logo"),
            style: .outline(stroke: Color.black.opacity(0.3),
                            background: .white,
                            foreground: .black),
            height: 58,
            font: FontMaker.makeFont(.poppinsSemiBold, fontSize),
            iconSize: 22
        ) {
            viewModel.teste()
        }
        .padding(.horizontal, defaultPadding)
        .padding(.bottom, 5)
    }
    
    private var createAccountWithGoogle: some View {
        CapsuleButton(
            title: String(localized: "auth.continueWithGoogle"),
            icon: .image(Image("VectorGoogle")),
            style: .outline(stroke: Color.black.opacity(0.3),
                            background: .white,
                            foreground: .black),
            height: 58,
            font: FontMaker.makeFont(.poppinsSemiBold, fontSize),
            iconSize: 22
        ) {
            print(register ? "login" : "register")
        }
        .padding(.horizontal, defaultPadding)
        .padding(.bottom, 5)
    }
    
    private var createAccountWithEmailAndPassword: some View {
        CapsuleButton(
            title: String(localized: "auth.continueWithEmail"),
            icon: nil,
            style: .filled(background: ColorsNames.darkBlue, foreground: .white),
            height: 58,
            font: FontMaker.makeFont(.poppinsSemiBold, fontSize)
        ) {
            register ? RegisterCoordinator(nav: nav).startRegister() : RegisterCoordinator(nav: nav).startLogin()
        }
        .padding(.horizontal, defaultPadding)
        .padding(.bottom, 5)
    }
}
