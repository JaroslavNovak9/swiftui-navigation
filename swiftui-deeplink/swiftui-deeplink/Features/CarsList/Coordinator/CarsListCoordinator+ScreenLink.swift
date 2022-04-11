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

        var id: String {
            switch self {
            case .carDetail, .carDetailParametrized:
                return "carDetail"
            case .carAssistance:
                return "carAssistance"
            }
        }
    }
}

extension CarsListCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        case .carDetailParametrized:
            return .carDetail
        default:
            return self
        }
    }
}
