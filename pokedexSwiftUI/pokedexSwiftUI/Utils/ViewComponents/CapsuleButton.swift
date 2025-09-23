//
//  CapsuleButton.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 23/09/25.
//

import SwiftUI

struct CapsuleButton: View {
    enum Icon {
        case system(String)
        case image(Image)
    }
    
    enum Style {
        case filled(background: Color, foreground: Color)
        case outline(stroke: Color = Color.black.opacity(0.3),
                     background: Color = .white,
                     foreground: Color = .black,
                     lineWidth: CGFloat = 1.5)
    }
    
    let title: String
    var icon: Icon? = nil
    var style: Style = .outline()
    var height: CGFloat = 58
    var font: Font = .body
    var iconSize: CGFloat = 20
    var hSpacing: CGFloat = 12
    let action: () -> Void
    
    var body: some View {
        let label = HStack(spacing: hSpacing) {
            Spacer()
            if let icon {
                switch icon {
                case .system(let name):
                    Image(systemName: name)
                        .font(.system(size: iconSize, weight: .regular))
                case .image(let img):
                    img
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                }
            }
            
            Text(title)
                .font(font)
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: height)
        
        switch style {
        case .filled(let background, let foreground):
            Button(action: action) {
                label
                    .foregroundStyle(foreground)
                
            }
            .background(background)
            .clipShape(Capsule())
            
        case .outline(let stroke, let background, let foreground, let lineWidth):
            Button(action: action) {
                label
                    .foregroundStyle(foreground)
            }
            .background(background)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(stroke, lineWidth: lineWidth)
            )
        }
    }
}

#Preview {
    CapsuleButton(
        title: "Continuar com a Apple",
        icon: .system("apple.logo"),
        style: .outline(stroke: Color.black.opacity(0.3),
                        background: .white,
                        foreground: .black),
        height: 58,
        font: FontMaker.makeFont(.poppinsSemiBold, 18),
        iconSize: 22
    ) {
        print("teste")
    }
}

#Preview {
    CapsuleButton(
        title: "Continuar com a Google",
        icon: .image(Image("VectorGoogle")),
        style: .outline(stroke: Color.black.opacity(0.3),
                        background: .white,
                        foreground: .black),
        height: 58,
        font: FontMaker.makeFont(.poppinsSemiBold, 18),
        iconSize: 22
    ) {
        print("teste")
    }
}

#Preview {
    CapsuleButton(
        title: "Continuar com um e-mail",
        icon: nil,
        style: .filled(background: ColorsNames.darkBlue, foreground: .white),
        height: 58,
        font: FontMaker.makeFont(.poppinsSemiBold, 18)
    ) {
        print("teste")
    }
}
