//
//  CarsListCoordinator+FullScreenLink.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 13.04.2022.
//

import Foundation

extension CarsListCoordinator {
    enum FullScreenLink: Identifiable {
        case carDocuments
        case carDocumentsParametrized(deepLink: DeepLink? = nil)

        var id: String {
            switch self {
            case .carDocuments, .carDocumentsParametrized:
                return "carDocuments"
            }
        }
    }
}

extension CarsListCoordinator.FullScreenLink {
    var unparametrized: Self {
        switch self {
        case .carDocumentsParametrized:
            return .carDocuments
        default:
            return self
        }
    }
}
