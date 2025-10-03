//
//  SignUpView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @EnvironmentObject var nav: AppNavigator
    @FocusState private var focused: Field?
    private enum Field: Hashable { case email, password, name }
    
    private var isCurrentFocused: Bool {
        switch viewModel.step {
        case .email:    return focused == .email
        case .password: return focused == .password
        case .name:     return focused == .name
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Spacer().frame(height: 30)
            
            VStack(alignment: .center, spacing: 6) {
                Text(LocalizedStringKey(viewModel.step.titleTop))
                    .font(FontMaker.makeFont(.poppinsRegular, 26))
                Text(LocalizedStringKey(viewModel.step.titleMain))
                    .font(FontMaker.makeFont(.poppinsSemiBold, 26))
            }
            .padding(.horizontal, 16)
            .transition(.opacity.combined(with: .move(edge: .top)))
            
            Group {
                switch viewModel.step {
                case .email:
                    TextField(LocalizedStringKey(viewModel.step.placeholder), text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .focused($focused, equals: .email)
                        .submitLabel(.next)
                        .onSubmit { handlePrimary() }
                    
                case .password:
                    ZStack(alignment: .trailing) {
                        TextField(LocalizedStringKey(viewModel.step.placeholder), text: $viewModel.password)
                            .opacity(viewModel.showPassword ? 1 : 0)
                            .focused($focused, equals: .password)
                            .submitLabel(.next)
                            .onSubmit { handlePrimary() }
                            .textContentType(.newPassword)
                            .autocorrectionDisabled(true)
                        
                        SecureField(LocalizedStringKey(viewModel.step.placeholder), text: $viewModel.password)
                            .opacity(viewModel.showPassword ? 0 : 1)
                            .focused($focused, equals: .password)
                            .submitLabel(.next)
                            .onSubmit { handlePrimary() }
                            .textContentType(.newPassword)
                            .autocorrectionDisabled(true)
                        
                        Button {
                            let wasFocused = (focused == .password)
                            viewModel.showPassword.toggle()
                            if wasFocused {
                                DispatchQueue.main.async { focused = .password }
                            }
                        } label: {
                            Image(systemName: viewModel.showPassword ? "eye" : "eye.slash")
                                .foregroundStyle(ColorsNames.darkBlue)
                        }
                        .padding(.trailing, 8)
                    }
                    
                case .name:
                    TextField(LocalizedStringKey(viewModel.step.placeholder), text: $viewModel.name)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(true)
                        .focused($focused, equals: .name)
                        .submitLabel(.done)
                        .onSubmit { handlePrimary() }
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isCurrentFocused ? ColorsNames.darkBlue : Color.gray.opacity(0.4), lineWidth: 2)
            )
            .padding(.horizontal, 16)
            .id(viewModel.step)
            .transition(.move(edge: .trailing).combined(with: .opacity))
            
            Text(LocalizedStringKey(viewModel.step.helperText))
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
                .transition(.opacity)
            
            Spacer()
            
            Button(action: handlePrimary) {
                ZStack {
                    Text(LocalizedStringKey(viewModel.step.buttonTitle))
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .font(.system(size: 18, weight: .semibold))
                    if viewModel.isLoading {
                        ProgressView().progressViewStyle(.circular)
                    }
                }
            }
            .disabled(!viewModel.isContinueEnabled || viewModel.isLoading)
            .background(viewModel.isContinueEnabled ? ColorsNames.darkBlue : Color.gray.opacity(0.25))
            .foregroundStyle(Color.white)
            .clipShape(Capsule())
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
    }
    
    private func focusInitial() {
        switch viewModel.step {
        case .email:    focused = .email
        case .password: focused = .password
        case .name:     focused = .name
        }
    }
    
    private func handleBack() {
        if viewModel.step == .email {
            SignUpCoordinator(nav: nav).back()
        } else {
            viewModel.previousStep()
        }
    }
    
    private func handlePrimary() {
        guard viewModel.isContinueEnabled else { return }
        
        if viewModel.step == .name {
            //            Task {
            //                if let user = await viewModel.submit() {
            // adapte aqui
            let user = viewModel.submitMockUser()
            SignUpCoordinator(nav: nav).finishedSignUp(user: user)
            //                }
            //            }
        } else {
            viewModel.nextStep()
        }
    }
}

// MARK: - Preview
#Preview {
    let nav = AppNavigator()
    let vm = SignUpViewModel(service: SignUpService())
    SignUpView(viewModel: vm)
        .environmentObject(nav)
}

#Preview {
    let nav = AppNavigator()
    let viewModel = SignUpViewModel()
    SignUpView(viewModel: viewModel)
        .environmentObject(nav)
}
