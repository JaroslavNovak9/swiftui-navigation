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
        if case let .carDetailParametrized(_, _, detailNestedLink) = deepLinkManager.currentInternalScreen {
            if detailNestedLink?.unparametrized == .carTechnicalInfo {
                selectedLink = .carTechnicalInfo
                deepLinkManager.currentInternalScreen = selectedLink
            }
        }
    }

    private func makeCarTechnicalInfoCoordinator(
        preselectedLink: DeepLink?
    ) -> CarTechnicalInfoCoordinator {
        .init(
            deepLinkManager: self.deepLinkManager,
            preselectedLink: preselectedLink
        )
    }

    func provideTechnicalInfoView() -> some View {
        var preselectedLink: DeepLink?

        if
            case let .carTechnicalInfoParametrized(nestedLink) = selectedLink
        {
            preselectedLink = nestedLink
        }

        return CarTechnicalInfoView(
            viewModel: CarTechnicalInfoVM(
                coordinator: makeCarTechnicalInfoCoordinator(preselectedLink: preselectedLink)
            )
        )
    }
}
