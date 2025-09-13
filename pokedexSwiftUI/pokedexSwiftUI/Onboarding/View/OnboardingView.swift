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
            
            VStack{
                Text("Todos os Pokémons em um só Lugar")
                    .font(Font.custom("Poppins-Medium.ttf", size: 26))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("Primary"))
                
                Text("Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo")
                    .font(Font.custom("Poppins-Regular.ttf", size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("Secondary"))
            }
        }
        .padding()

    }
}

#Preview {
    OnboardingView()
}
