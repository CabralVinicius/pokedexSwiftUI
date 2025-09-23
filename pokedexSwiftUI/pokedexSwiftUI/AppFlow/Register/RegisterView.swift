//
//  RegisterView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    private let defaultPadding: CGFloat = 16
    private let fontSize: CGFloat = 18
    private let imageSize: CGFloat = 27
    
    var body: some View {
        VStack{
            Spacer().frame(height: 90)
            MakeTraningImage(firstImage: ImageKey.maleCoachFive.rawValue)
            TitleDescriptionView(title: viewModel.loginOrRegisterInformations.title, description: viewModel.loginOrRegisterInformations.description)
            Spacer().frame(height: 45)
            createAccountWithApple
            createAccountWithGoogle
            createAccountWithEmailAndPassword
        }
    }
        
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
            // ação Google
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

#Preview {
    RegisterView(viewModel: RegisterViewModel())
}
