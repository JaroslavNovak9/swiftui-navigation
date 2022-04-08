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

    private func makeCarDetailCoordinator(
        preselectedLink: CarDetailCoordinator.Flow?
    ) -> CarDetailCoordinator {
        .init(
            deepLinkManager: self.deepLinkManager,
            preselectedLink: preselectedLink
        )
    }

    func provideDetailView() -> some View {
        var carBrandString: String?
        var carModelString: String?
        var nestedLink: CarDetailCoordinator.Flow?

        if
            case let .detailParametrized(carBrand, carModel, deepLink) = selectedLink
        {
            carBrandString = carBrand
            carModelString = carModel

            // TODO: - Add mapping
            switch deepLink {
            case .technicalInfo:
                nestedLink = .technicalInfo
            default:
                break
            }
        }

        let viewModel: CarDetailVM = .init(
            carBrandString: carBrandString ?? "",
            carModelString: carModelString ?? "",
            carDetailCoordinator: makeCarDetailCoordinator(preselectedLink: nestedLink)
        )
        let view: CarDetailView = .init(viewModel: viewModel)

        return view
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
