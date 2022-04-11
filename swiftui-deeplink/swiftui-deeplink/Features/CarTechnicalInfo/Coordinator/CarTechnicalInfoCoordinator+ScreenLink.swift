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

        var id: String {
            switch self {
            case .carAssistance:
                return "carAssistance"
            }
        }
    }
}

extension CarTechnicalInfoCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        default:
            return self
        }
    }
}
