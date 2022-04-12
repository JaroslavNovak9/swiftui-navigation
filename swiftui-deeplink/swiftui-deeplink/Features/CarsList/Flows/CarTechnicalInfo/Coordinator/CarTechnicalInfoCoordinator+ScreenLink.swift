//
//  CarTechnicalInfoCoordinator+ScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import Foundation

extension CarTechnicalInfoCoordinator {
    enum ScreenLink: Identifiable, Hashable {
        case carAssistance
        case carAssistanceParametrized(deepLink: DeepLink?)
        case carDetail

        var id: String {
            switch self {
            case .carDetail:
                return "carDetail"
            case .carAssistance, .carAssistanceParametrized:
                return "carAssistance"
            }
        }
    }
}

extension CarTechnicalInfoCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        case .carAssistanceParametrized:
            return .carAssistance
        default:
            return self
        }
    }
}
