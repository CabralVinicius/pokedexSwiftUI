//
//  NavToolbarModifier.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 27/09/25.
//

import SwiftUI

enum NavTrailing {
    case text(String, action: () -> Void)
    case systemImage(String, action: () -> Void)
}

struct NavToolbarModifier: ViewModifier {
    let leadingTitle: String?
    let onBack: () -> Void
    let centerTitle: String?
    let trailing: NavTrailing?
    let systemImage: String
    var tint: Color = ColorsNames.primary
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // LEADING
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: onBack) {
                        HStack(spacing: 8) {
                            Image(systemName: systemImage)
                            Text(leadingTitle ?? "")
                                .font(FontMaker.makeFont(.poppinsSemiBold, 18))
                        }
                    }
                    .tint(tint)
                }
                
                // CENTER (principal)
                if let centerTitle {
                    ToolbarItem(placement: .principal) {
                        Text(centerTitle)
                            .font(FontMaker.makeFont(.poppinsSemiBold, 18))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundStyle(tint)
                    }
                }
                
                // TRAILING
                if let trailing {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        switch trailing {
                        case .text(let title, let action):
                            Button(title, action: action)
                                .font(FontMaker.makeFont(.poppinsSemiBold, 16))
                                .tint(tint)
                        case .systemImage(let name, let action):
                            Button(action: action) {
                                Image(systemName: name)
                            }
                            .tint(tint)
                        }
                    }
                }
            }
    }
}

#Preview("Com título central + trailing ícone") {
    NavigationStack {
        VStack(spacing: 24) {
            Text("Conteúdo de exemplo")
                .padding()
        }
        .navToolbar(
            leadingTitle: "voltar",
            centerTitle: "Centralizado",
            trailing: .systemImage("gearshape") { print("trailing tapped") },
            onBack: { print("back tapped") }
        )
    }
}

#Preview("Sem título central") {
    NavigationStack {
        VStack(spacing: 24) {
            Text("Outra tela")
                .padding()
        }
        .navToolbar(
            leadingTitle: "voltar",
            onBack: { print("back tapped") }
        )
    }
}

extension View {
    func navToolbar(
        leadingTitle: String? = nil,
        centerTitle: String? = nil,
        trailing: NavTrailing? = nil,
        systemImage: String = "chevron.left",
        tint: Color = ColorsNames.primary,
        onBack: @escaping () -> Void
    ) -> some View {
        modifier(
            NavToolbarModifier(
                leadingTitle: leadingTitle,
                onBack: onBack,
                centerTitle: centerTitle,
                trailing: trailing,
                systemImage: systemImage,
                tint: tint
            ))
    }
}
