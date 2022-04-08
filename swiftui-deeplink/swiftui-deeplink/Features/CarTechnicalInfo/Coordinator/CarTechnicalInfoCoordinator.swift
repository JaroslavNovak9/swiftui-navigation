//
//  CarTechnicalInfoCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import SwiftUI

final class CarTechnicalInfoCoordinator: ObservableObject {

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
        if case let .carDetailParametrized(_, _, nestedLink: nestedLink) = deepLinkManager.currentInternalScreen {
            if case let .carTechnicalInfoParametrized(technicalInfoNestedLink) = nestedLink {
                if technicalInfoNestedLink?.unparametrized == .carAssistance {
                    selectedLink = .carAssistance
                    deepLinkManager.currentInternalScreen = selectedLink
                }
            }
        }

    }

    func provideCarAssistanceView() -> some View {
        CarAssistanceView()
    }
}
