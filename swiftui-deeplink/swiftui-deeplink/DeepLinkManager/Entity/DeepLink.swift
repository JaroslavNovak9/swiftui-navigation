//
//  DeepLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import Foundation

indirect enum DeepLink {
    case carsList
    case carsListParametrized(nestedLink: Self? = nil)
    case carDetail
    case carDetailParametrized(
        carBrand: String,
        carModel: String,
        nestedLink: Self? = nil
    )
    case carTechnicalInfo
}

extension DeepLink {
    var unparametrized: Self {
        switch self {
        case .carsListParametrized:
            return .carsList
        case .carDetailParametrized:
            return .carDetail
        default:
            return self
        }
    }
}

extension DeepLink: Identifiable {
    var id: String {
        switch self {
        case .carsList, .carsListParametrized:
            return "carsList"
        case .carDetail, .carDetailParametrized:
            return "carDetail"
        case .carTechnicalInfo:
            return "carTechnicalInfo"
        }
    }
}

extension DeepLink: Hashable {
    
}
