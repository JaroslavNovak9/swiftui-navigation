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
    case carTechnicalInfoParametrized(nestedLink: Self? = nil)
    case carAssistance
}

extension DeepLink {
    var unparametrized: Self {
        switch self {
        case .carsListParametrized:
            return .carsList
        case .carDetailParametrized:
            return .carDetail
        case .carTechnicalInfoParametrized:
            return .carTechnicalInfo
        default:
            return self
        }
    }
}

extension DeepLink: Identifiable, Hashable {
    var id: String {
        switch self {
        case .carsList, .carsListParametrized:
            return "carsList"
        case .carDetail, .carDetailParametrized:
            return "carDetail"
        case .carTechnicalInfo, .carTechnicalInfoParametrized:
            return "carTechnicalInfo"
        case .carAssistance:
            return "carAssistance"
        }
    }
}
