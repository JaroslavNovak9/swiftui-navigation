//
//  CarDetailCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

final class CarDetailCoordinator: ObservableObject {

    let deepLinkManager: DeepLinkManager
    @Published var selectedLink: DeepLink?

    init(
        deepLinkManager: DeepLinkManager,
        preselectedLink: DeepLink? = nil
    ) {
        self.deepLinkManager = deepLinkManager
        self.selectedLink = preselectedLink
        // Setup
        setupDeepLinking()
    }

    private func setupDeepLinking() {
//        if case let .detailParametrized(carBrand, carModel) = deepLinkManager.currentInternalScreen {
//            selectedLink = .detailParametrized(
//                carBrand: carBrand,
//                carModel: carModel
//            )
//        }
    }

    func provideTechnicalInfoView() -> some View {
        CarTechnicalInfoView()
    }
}
