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
    var isLogin: Bool
    private let defaultPadding: CGFloat = 16
    private let fontSize: CGFloat = 18
    private let imageSize: CGFloat = 27
    
    var body: some View {
        VStack{
            Spacer().frame(height: 90)
            MakeTrainingImage(
                firstImage:
                    isLogin ?
                ImageKey.maleCoachFive.rawValue :
                    ImageKey.maleCoachFour.rawValue)
            TitleDescriptionView(title: isLogin ? viewModel.loginOrRegisterInformations[0].titleKey : viewModel.loginOrRegisterInformations[1].titleKey, description: viewModel.loginOrRegisterInformations[0].descriptionKey)
            Spacer().frame(height: 45)
            createAccountWithApple
            createAccountWithGoogle
            createAccountWithEmailAndPassword
        }
        .navToolbar(centerTitle: isLogin ? "Cadastro" : "Login"){
            RegisterCoordinator(nav: nav).back()
        }
    }
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(), isLogin: true)
        .environmentObject(AppNavigator())
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(), isLogin: false)
        .environmentObject(AppNavigator())
}

extension RegisterView {
    private var createAccountWithApple: some View {
        CapsuleButton(
            title: "Continuar com a Apple",
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
            title: "Continuar com a Google",
            icon: .image(Image("VectorGoogle")),
            style: .outline(stroke: Color.black.opacity(0.3),
                            background: .white,
                            foreground: .black),
            height: 58,
            font: FontMaker.makeFont(.poppinsSemiBold, fontSize),
            iconSize: 22
        ) {
            print(isLogin ? "login" : "cadastro")
        }
        .padding(.horizontal, defaultPadding)
        .padding(.bottom, 5)
    }
    
    private var createAccountWithEmailAndPassword: some View {
        CapsuleButton(
            title: "Continuar com um e-mail",
            icon: nil,
            style: .filled(background: ColorsNames.darkBlue, foreground: .white),
            height: 58,
            font: FontMaker.makeFont(.poppinsSemiBold, fontSize)
        ) {
            // ação e-mail
        }
        .padding(.horizontal, defaultPadding)
        .padding(.bottom, 5)
    }
}
