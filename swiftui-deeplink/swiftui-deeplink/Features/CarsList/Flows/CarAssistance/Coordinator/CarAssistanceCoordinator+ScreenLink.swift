//
//  CarAssistanceCoordinator+ScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 12.04.2022.
//

import Foundation

extension CarAssistanceCoordinator {
    enum ScreenLink: Identifiable, Hashable {
        case carTechnicalInfo
        case carTechnicalInfoParametrized(deepLink: DeepLink?)

        var id: String {
            switch self {
            case .carTechnicalInfo, .carTechnicalInfoParametrized:
                return "carTechnicalInfo"
            }
        }
    }
}

extension CarAssistanceCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        case .carTechnicalInfoParametrized:
            return .carTechnicalInfo
        default:
            return self
        }
    }
}
