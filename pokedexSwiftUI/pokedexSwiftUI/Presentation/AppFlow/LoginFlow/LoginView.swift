//
//  LoginView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 02/11/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var showPassword = false
    
    private var isFormValid: Bool {
        !viewModel.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !viewModel.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Bem vindo de volta!")
                .font(FontMaker.makeFont(.poppinsRegular, 26))
                .padding(.top, 30)
            
            Text("Preencha os dados")
                .font(FontMaker.makeFont(.poppinsSemiBold, 26))
                .padding(.bottom, 20)
        }
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("E-mail")
                .font(FontMaker.makeFont(.poppinsRegular, 15))
            
            TextField("E-mail", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .autocorrectionDisabled(true)
                .submitLabel(.next)
                .padding(.horizontal, 12)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                )
            
            Text("Senha")
                .font(FontMaker.makeFont(.poppinsRegular, 16))
            
            ZStack(alignment: .trailing) {
                TextField("Senha", text: $viewModel.password)
                    .opacity(showPassword ? 1 : 0)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.password)
                    .submitLabel(.done)
                
                SecureField("Senha", text: $viewModel.password)
                    .opacity(showPassword ? 0 : 1)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.password)
                    .submitLabel(.done)
                
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 2)
            )
            
            // Esqueceu a senha (como no print)
            Button(action: {
                // TODO: recuperar senha
            }) {
                Text("Esqueceu sua senha?")
                    .font(FontMaker.makeFont(.poppinsRegular, 16))
                    .foregroundColor(ColorsNames.darkBlue)
                    .transition(.opacity)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        
        Spacer()
        
        Button(action: {
            // TODO: login
        }) {
            Text("Entrar")
                .font(FontMaker.makeFont(.poppinsSemiBold, 16))
                .foregroundColor(.white.opacity(isFormValid ? 1 : 0.6))
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 27)
                        .fill(Color.gray.opacity(isFormValid ? 0.9 : 0.35))
                )
        }
        .disabled(!isFormValid)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
