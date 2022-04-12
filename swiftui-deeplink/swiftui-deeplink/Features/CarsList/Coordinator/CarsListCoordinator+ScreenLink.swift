//
//  CarsListCoordinator+ScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import Foundation

extension CarsListCoordinator {
    enum ScreenLink: Identifiable, Hashable {
        case carDetail
        case carDetailParametrized(
            carBrand: String,
            carModel: String,
            deepLink: DeepLink? = nil
        )
        case carAssistance
        case carAssistanceParametrized(
            deepLink: DeepLink? = nil
        )
        case carTechnicalInfo
        case carTechnicalInfoParametrized(
            deepLink: DeepLink? = nil
        )

        var id: String {
            switch self {
            case .carDetail, .carDetailParametrized:
                return "carDetail"
            case .carTechnicalInfo, .carTechnicalInfoParametrized:
                return "carTechnicalInfo"
            case .carAssistance, .carAssistanceParametrized:
                return "carAssistance"
            }
        }
    }
}

extension CarsListCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        case .carTechnicalInfoParametrized:
            return .carTechnicalInfo
        case .carDetailParametrized:
            return .carDetail
        case .carAssistanceParametrized:
            return .carAssistance
        default:
            return self
        }
    }
}
