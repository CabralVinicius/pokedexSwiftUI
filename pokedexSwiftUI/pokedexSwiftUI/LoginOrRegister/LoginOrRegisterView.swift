//
//  LoginOrRegisterView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI

struct LoginOrRegisterView: View {
    @ObservedObject var viewModel: LoginOrRegisterViewModel
    
    var body: some View {
        VStack{
            jumpButtonView
            Spacer().frame(height: 175)
            traningImageView
            TitleDescriptionView(title: viewModel.loginOrRegisterInformations.title, description: viewModel.loginOrRegisterInformations.description)
            Spacer().frame(height: 45)
            createAccount
            Spacer().frame(height: 16)
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
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .foregroundStyle(.black)

                    Image(systemName: "arrow.forward")
                        .frame(width: 27, height: 27)
                        .foregroundStyle(.black)
                }
            })
        }
        .padding(.horizontal, 16)
    }
    
    var traningImageView: some View {
        ZStack {
            Image("treinadora2")
                .offset(x: -50)
                .background {
                    Image("sombra")
                        .offset(x: -65, y: 110)
                }

            Image("treinador3")
                .offset(x: 50, y: -10)
                .background {
                    Image("sombra")
                        .offset(x: 50, y: 115)
                }
        }
    }    
    
    private var createAccount: some View {
        Button(action: {
            // ação (pular para próxima tela, etc.)
        }, label: {
            Rectangle()
                .frame(height: 58)
                .clipShape(.capsule)
                .foregroundStyle(Color("DarkBlue"))
                .overlay {
                    Text("Criar conta")
                        .foregroundStyle(.white)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 15)
        })
    }
    
    private var registerAccount: some View {
        Button(action: {
            // ação (pular para próxima tela, etc.)
        }, label: {
                    Text("Ja tenho uma conta")
                .foregroundStyle(Color("DarkBlue"))
                        .font(Font.custom("Poppins-SemiBold", size: 18))
        })
        .padding(.horizontal, 16)
        .padding(.bottom, 15)
    }
}

#Preview {
    LoginOrRegisterView(viewModel: LoginOrRegisterViewModel())
}
