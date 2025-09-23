//
//  LoginOrRegisterView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI

struct LoginOrRegisterView: View {
    @ObservedObject var viewModel: LoginOrRegisterViewModel
    private let defaultPadding: CGFloat = 16
    private let fontSize: CGFloat = 18
    private let imageSize: CGFloat = 27
    
    var body: some View {
        VStack{
            jumpButtonView
            Spacer().frame(height: 175)
            MakeTrainingImage(firstImage: ImageKey.femaleCoachTwo.rawValue, secondImage: ImageKey.maleCoachThree.rawValue)
            TitleDescriptionView(title: viewModel.loginOrRegisterInformations.titleKey, description: viewModel.loginOrRegisterInformations.descriptionKey)
            Spacer().frame(height: 45)
            createAccount
            Spacer().frame(height: defaultPadding)
            registerAccount
        }
    }
    
    var jumpButtonView: some View {
        HStack{
            Spacer()
            Button(action: {
                // ação (pular para próxima tela, etc.)
            }, label: {
                HStack{
                    Text("Voltar")
                        .font(FontMaker.makeFont(.poppinsSemiBold, fontSize))
                        .foregroundStyle(.black)

                    Image(systemName: "arrow.forward")
                        .frame(width: imageSize, height: imageSize)
                        .foregroundStyle(.black)
                }
            })
        }
        .padding(.horizontal, defaultPadding)
    }
    
    private var createAccount: some View {
        Button(action: {
            // ação (pular para próxima tela, etc.)
        }, label: {
            Rectangle()
                .frame(height: 58)
                .clipShape(.capsule)
                .foregroundStyle(ColorsNames.darkBlue)
                .overlay {
                    Text("Criar conta")
                        .foregroundStyle(.white)
                        .font(FontMaker.makeFont(.poppinsSemiBold, fontSize))
                }
                .padding(.horizontal, defaultPadding)
                .padding(.bottom, defaultPadding)
        })
    }
    
    private var registerAccount: some View {
        Button(action: {
            // ação (pular para próxima tela, etc.)
        }, label: {
                    Text("Ja tenho uma conta")
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
