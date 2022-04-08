//
//  CarDetailCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

final class CarDetailCoordinator: ObservableObject {

    let deepLinkManager: DeepLinkManager
    @Published var selectedLink: Flow?

    init(
        deepLinkManager: DeepLinkManager,
        preselectedLink: Flow? = nil
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

extension CarDetailCoordinator {
    enum Flow: Hashable {
        case technicalInfo
    }
}

extension CarDetailCoordinator.Flow {
    var navigationLink: Self {
        switch self {
        default:
            return self
        }
    }
}

extension CarDetailCoordinator.Flow: Identifiable {
    var id: String {
        switch self {
        case .technicalInfo:
            return "technicalInfo"
        }
    }
}
