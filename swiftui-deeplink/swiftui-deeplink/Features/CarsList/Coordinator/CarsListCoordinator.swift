//
//  CarsListCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

final class CarsListCoordinator: ObservableObject {

    let deepLinkManager: DeepLinkManager
    @Published var selectedLink: DeepLink?

    init(deepLinkManager: DeepLinkManager) {
        self.deepLinkManager = deepLinkManager
        // Setup
        setupDeepLinking()
    }

    private func setupDeepLinking() {
        if case let .carDetailParametrized(carBrand, carModel, _) = deepLinkManager.currentInternalScreen {
            selectedLink = .carDetailParametrized(
                carBrand: carBrand,
                carModel: carModel
            )
        }

        if case .carTechnicalInfo = deepLinkManager.currentInternalScreen?.unparametrized {
            selectedLink = .carDetailParametrized(
                carBrand: "",
                carModel: "",
                nestedLink: .carTechnicalInfo
            )
        }

        if case .carAssistance = deepLinkManager.currentInternalScreen?.unparametrized {
            selectedLink = .carDetailParametrized(
                carBrand: "",
                carModel: "",
                nestedLink: .carTechnicalInfoParametrized(
                    nestedLink: .carAssistance
                )
            )
        }
    }

    private func makeCarDetailCoordinator(
        preselectedLink: DeepLink?
    ) -> CarDetailCoordinator {
        .init(
            deepLinkManager: self.deepLinkManager,
            preselectedLink: preselectedLink
        )
    }

    func provideDetailView() -> some View {
        var carBrandString: String?
        var carModelString: String?
        var preselectedLink: DeepLink?

        if
            case let .carDetailParametrized(carBrand, carModel, nestedLink) = selectedLink
        {
            carBrandString = carBrand
            carModelString = carModel
            preselectedLink = nestedLink
        }

        let viewModel: CarDetailVM = .init(
            carBrandString: carBrandString ?? "",
            carModelString: carModelString ?? "",
            carDetailCoordinator: makeCarDetailCoordinator(preselectedLink: preselectedLink)
        )
        let view: CarDetailView = .init(viewModel: viewModel)

        return view
    }
}
