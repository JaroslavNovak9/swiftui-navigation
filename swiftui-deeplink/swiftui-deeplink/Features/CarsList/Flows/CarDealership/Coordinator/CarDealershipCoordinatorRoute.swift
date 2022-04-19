//
//  CarDealershipCoordinatorRoute.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 19.04.2022.
//

import Foundation

enum CarDealershipCoordinatorRoute: Equatable, Hashable, Identifiable {
    case dealershipInfoParametrized(CarDealershipView.DealershipInfo)
    case dealershipInfo

    var id: String {
        switch self {
        case .dealershipInfo, .dealershipInfoParametrized:
            return "dealershipInfo"
        }
    }

    var unparametrized: Self {
        switch self {
        case .dealershipInfoParametrized:
            return .dealershipInfo
        default:
            return self
        }
    }
}
