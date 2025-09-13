//
//  OnboardingView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 13/09/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            trainersImages
            Spacer().frame(height: 45)
            titleAndDescription
            Spacer().frame(height: 24)
            onboardingProgressView
            Spacer().frame(height: 45)
            continueButton
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .bottom)
        .padding(.horizontal, 16)
    }
    
    // MARK: - trainersImages
    var trainersImages: some View {
        ZStack{
            Image("treinador1")
                .offset(x: -50)
                .background{
                    Image("sombra")
                        .offset(x: -65, y: 110)
                }
            Image("treinador2")
                .offset(x: 50, y: -10)
                .background{
                    Image("sombra")
                        .offset(x: 50, y: 115)
                }
        }
    }
    
    // MARK: - titleAndDescription
    var titleAndDescription: some View {
        VStack(spacing: 16){
            Text("Todos os Pokémons em um só Lugar")
                .font(Font.custom("Poppins-Medium", size: 26))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("AppPrimary"))
            
            Text("Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo")
                .font(Font.custom("Poppins-Regular", size: 14))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("AppSecondary"))
        }
    }
    
    // MARK: - onboardingProgressView
    var onboardingProgressView: some View {
        HStack{
            Rectangle()
                .frame(width: 28, height: 9)
                .clipShape(.capsule)
                .foregroundStyle(Color("DarkBlue"))
            Circle()
                .frame(width: 9, height: 9)
                .foregroundStyle(Color(.lightGray))
        }
    }
    
    // MARK: - continueButton
    var continueButton: some View {
        Button(action: {
            
        }, label: {
            Rectangle()
                .frame(height: 58)
                .clipShape(.capsule)
                .foregroundStyle(Color("DarkBlue"))
                .overlay {
                    Text("Continuar")
                        .foregroundStyle(.white)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                }
        })
    }
}

#Preview {
    OnboardingView()
}
