//
//  CarsListCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

final class CarsListCoordinator: ObservableObject {

    let deepLinkManager: DeepLinkManager
    @Published var selectedLink: Flow?

    init(deepLinkManager: DeepLinkManager) {
        self.deepLinkManager = deepLinkManager
        // Setup
        setupDeepLinking()
    }

    private func setupDeepLinking() {
        if case let .detailParametrized(carBrand, carModel) = deepLinkManager.currentInternalScreen {
            selectedLink = .detailParametrized(
                carBrand: carBrand,
                carModel: carModel
            )
        }

        if case .technicalInfo = deepLinkManager.currentInternalScreen {
            selectedLink = .detailParametrized(
                carBrand: "",
                carModel: "",
                deepLink: .technicalInfo
            )
        }
    }
}

extension CarsListCoordinator {
    enum Flow: Hashable {
        case detail
        case detailParametrized(
            carBrand: String,
            carModel: String,
            deepLink: DeepLinkManager.InternalScreens? = nil
        )
    }
}

extension CarsListCoordinator.Flow {
    var navigationLink: Self {
        switch self {
        case .detailParametrized:
            return .detail
        default:
            return self
        }
    }
}

extension CarsListCoordinator.Flow: Identifiable {
    var id: String {
        switch self {
        case .detail, .detailParametrized:
            return "detail"
        }
    }
}
