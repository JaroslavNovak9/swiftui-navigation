//
//  CarsListCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import Combine
import SwiftUI

final class CarsListCoordinator: ObservableObject {

    private let deepLinkManager: DeepLinkManager
    private var cancellables = Set<AnyCancellable>()

    @Published var activeLink: CarsListCoordinator.ScreenLink?

    init(deepLinkManager: DeepLinkManager) {
        self.deepLinkManager = deepLinkManager
        // Setup
        setupDeepLinking()
    }

    private func setupDeepLinking() {
        deepLinkManager
            .outDeepLink
            .sink { [weak self] deepLink in
                guard let deepLink = deepLink else { return }

                if case let .carDetailParametrized(carBrand, carModel, deepLink) = deepLink {
                    self?.activeLink = .carDetailParametrized(
                        carBrand: carBrand,
                        carModel: carModel,
                        deepLink: deepLink
                    )
                }
            }
            .store(in: &cancellables)
    }

    private func makeCarDetailCoordinator(
        deepLink: DeepLink?
    ) -> CarDetailCoordinator {
        .init(
            deepLink: deepLink
        )
    }

    func provideDetailView() -> some View {
        var carBrandString: String?
        var carModelString: String?
        var preselectedDeepLink: DeepLink?

        if
            case let .carDetailParametrized(carBrand, carModel, deepLink) = activeLink
        {
            carBrandString = carBrand
            carModelString = carModel
            preselectedDeepLink = deepLink
        }

        let viewModel: CarDetailVM = .init(
            carBrandString: carBrandString ?? "",
            carModelString: carModelString ?? "",
            carDetailCoordinator: makeCarDetailCoordinator(
                deepLink: preselectedDeepLink
            )
        )
        let view: CarDetailView = .init(viewModel: viewModel)
        return view
    }

    func provideAssistanceView() -> some View {
        let view: CarAssistanceView = .init()

        return view
    }
}
