//
//  SignUpView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    var body: some View {
        VStack{
            Spacer().frame(height: 30)
            Text("Vamos começar?")
                .font(FontMaker.makeFont(.poppinsRegular, 26))
            Text("Qual o seu email?")
                .font(FontMaker.makeFont(.poppinsSemiBold, 26))
            
            TextField("E-mail", text: $viewModel.user.email) { editChange in
                viewModel.focusTextView = true
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .font(FontMaker.makeFont(.poppinsMedium, 16))
            .padding(.horizontal, 16)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2.5)
                    .foregroundStyle(viewModel.focusTextView ? .gray : .red)
                    .frame(height: 52)
            }
            .padding(.horizontal, 16)
            .padding()
            
            Text("User um endereço de email valido")
                .font(FontMaker.makeFont(.poppinsRegular, 14))
                .foregroundStyle(Color.gray)
            Spacer()
            continueButton
                
        }
    }
    
    private var continueButton: some View {
        CapsuleButton(
            title: "Continuar",
            style: .outline(stroke: Color.black.opacity(0.3),
                            background: ColorsNames.darkBlue,
                            foreground: .white),
            height: 58,
            font: FontMaker.makeFont(.poppinsSemiBold, 18),
            iconSize: 22
        ) {
            // Action
            print("teste")
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 5)
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel(user: SignUpModel(name: "", email: "", password: "")))
}
