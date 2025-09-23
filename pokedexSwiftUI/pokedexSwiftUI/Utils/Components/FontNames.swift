//
//  FontNames.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 23/09/25.
//

import Foundation
import SwiftUI

public enum FontNames: String {
    case poppisBold = "Poppins-Bold"
    case poppisExtraLight = "Poppins-ExtraLight"
    case poppisLight = "Poppins-Light"
    case poppinsMedium = "Poppins-Medium"
    case poppinsRegular = "Poppins-Regular"
    case poppinsSemiBold = "Poppins-SemiBold"
}

struct FontMaker {
    static func makeFont(_ font: FontNames, _ size: CGFloat) -> Font {
        Font.custom(font.rawValue, fixedSize: size)
    }
}
