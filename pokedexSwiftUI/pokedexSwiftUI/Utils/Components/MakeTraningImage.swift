//
//  MakeTraningImage.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 21/09/25.
//

import SwiftUI

struct MakeTraningImage: View {
    let firstImage: String
    let secondImage: String?
    
    init(firstImage: String, secondImage: String? = nil) {
        self.firstImage = firstImage
        self.secondImage = secondImage
    }
    
    var body: some View {
        ZStack {
            if let secondImage {
                Image(firstImage)
                    .offset(x: -50)
                    .background {
                        Image("sombra")
                            .offset(x: -65, y: 110)
                    }
                
                Image(secondImage)
                    .offset(x: 50, y: -10)
                    .background {
                        Image("sombra")
                            .offset(x: 50, y: 115)
                    }
            } else {
                ZStack {
                    Image(firstImage)
                        .offset(x: 10)
                        .background {
                            Image("sombra")
                                .offset(x: 5, y: 115)
                        }
                }
            }
        }
    }
}

#Preview {
    MakeTraningImage(firstImage: "treinador4", secondImage: "treinador3")
}
