//
//  CarDetailCoordinator+ScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import Foundation

extension CarDetailCoordinator {
    enum ScreenLink: Identifiable, Hashable {
        case carTechnicalInfo
        case carTechnicalInfoParametrized(
            deepLink: DeepLink? = nil
        )

        var id: String {
            switch self {
            case .carTechnicalInfo, .carTechnicalInfoParametrized:
                return "carTechnicalInfo"
            }
        }
    }
}

extension CarDetailCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        case .carTechnicalInfoParametrized:
            return .carTechnicalInfo
        default:
            return self
        }
    }
}
