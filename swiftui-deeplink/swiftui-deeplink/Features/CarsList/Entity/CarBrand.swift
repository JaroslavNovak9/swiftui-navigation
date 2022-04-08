//
//  CarBrand.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import Foundation

enum CarBrand {
    case bmw
    case nissan
    case audi
    case toyota
}

extension CarBrand {
    var stringTitle: String {
        switch self {
        case .bmw:
            return "BMW"
        case .nissan:
            return "Nissan"
        case .audi:
            return "Audi"
        case .toyota:
            return "Toyota"
        }
    }
}
