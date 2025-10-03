//
//  TitleDescriptionView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI

struct TitleDescriptionView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(LocalizedStringKey(title))
                .font(Font.custom("Poppins-Medium", size: 26))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("AppPrimary"))

            Text(LocalizedStringKey(description))
                .font(Font.custom("Poppins-Regular", size: 14))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("AppSecondary"))
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    TitleDescriptionView(title: "Titulo", description: "Description")
}
