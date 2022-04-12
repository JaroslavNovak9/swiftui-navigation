//
//  IdentificationCoordinator+ScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import SwiftUI

extension IdentificationCoordinator {
    enum ScreenLink: Identifiable, Hashable {
        case carsList

        var id: String {
            switch self {
            case .carsList:
                return "carsList"
            }
        }
    }
}

extension IdentificationCoordinator.ScreenLink {
    var unparametrized: Self {
        switch self {
        default:
            return self
        }
    }
}
