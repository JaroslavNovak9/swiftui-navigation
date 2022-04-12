//
//  CarDetailCoordinator+ScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import Foundation

extension CarDetailCoordinator {
    enum ScreenLink: Identifiable, Hashable {
        case carDetail
        case carDetailParametrized(
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
            case .carAssistance, .carAssistanceParametrized:
                return "carAssistance"
            case .carTechnicalInfo, .carTechnicalInfoParametrized:
                return "carTechnicalInfo"
            }
        }
    }
}

extension CarDetailCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        case .carAssistanceParametrized:
            return .carAssistance
        case .carDetailParametrized:
            return .carDetail
        case .carTechnicalInfoParametrized:
            return .carTechnicalInfo
        default:
            return self
        }
    }
}
